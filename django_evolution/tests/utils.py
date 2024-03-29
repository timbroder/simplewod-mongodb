import copy

from datetime import datetime
from django.core.management import sql
from django.core.management.color import no_style
from django.db import connection, transaction, settings, models
from django.db.backends.util import truncate_name
from django.db.models.loading import cache
from django.utils.datastructures import SortedDict
from django.utils.functional import curry

from django_evolution import signature
from django_evolution.tests import models as evo_test
from django_evolution.utils import write_sql, execute_sql


DEFAULT_TEST_ATTRIBUTE_VALUES = {
    models.CharField: 'TestCharField',
    models.IntegerField: '123',
    models.AutoField: None,
    models.DateTimeField: datetime.now(),
    models.PositiveIntegerField: '42'
}


def wrap_sql_func(func, evo_test, style):
    try:
        from django.db import connections

        # Django >= 1.2
        return func(evo_test, style, connections['default'])
    except ImportError:
        # Django < 1.2
        return func(evo_test, style)


# Wrap the sql.* functions to work with the multi-db support
sql_create = curry(wrap_sql_func, sql.sql_create)
sql_indexes = curry(wrap_sql_func, sql.sql_indexes)
sql_delete = curry(wrap_sql_func, sql.sql_delete)


def register_models(*models):
    app_cache = SortedDict()

    max_name_length = connection.ops.max_name_length()

    for name, model in reversed(models):
        if model._meta.module_name in cache.app_models['django_evolution']:
            del cache.app_models['django_evolution'][model._meta.module_name]

            orig_db_table = model._meta.db_table
            orig_object_name = model._meta.object_name
            orig_module_name = model._meta.module_name

            generated_db_table = truncate_name(
                '%s_%s' % (model._meta.app_label, model._meta.module_name),
                max_name_length)

            if orig_db_table.startswith(generated_db_table):
                model._meta.db_table = 'tests_%s' % name.lower()

            model._meta.db_table = truncate_name(model._meta.db_table,
                                                 max_name_length)
            model._meta.app_label = 'tests'
            model._meta.object_name = name
            model._meta.module_name = name.lower()

            add_app_test_model(model)

            for field in model._meta.local_many_to_many:
                if not field.rel.through:
                    continue

                through = field.rel.through

                generated_db_table = truncate_name(
                    '%s_%s' % (orig_db_table, field.name),
                    max_name_length)

                if through._meta.db_table == generated_db_table:
                    through._meta.app_label = 'tests'

                    # Transform the 'through' table information only
                    # if we've transformed the parent db_table.
                    if model._meta.db_table != orig_db_table:
                        through._meta.db_table = \
                            '%s_%s' % (model._meta.db_table, field.name)

                        through._meta.object_name = \
                            through._meta.object_name.replace(
                                orig_object_name,
                                model._meta.object_name)

                        through._meta.module_name = \
                            through._meta.module_name.replace(
                                orig_module_name,
                                model._meta.module_name)

                through._meta.db_table = \
                    truncate_name(through._meta.db_table, max_name_length)

                for field in through._meta.local_fields:
                    if field.rel and field.rel.to:
                        column = field.column

                        if (column.startswith(orig_module_name) or
                            column.startswith('to_%s' % orig_module_name) or
                            column.startswith('from_%s' % orig_module_name)):

                            field.column = column.replace(
                                orig_module_name,
                                model._meta.module_name)

                app_cache[through._meta.module_name] = through
                add_app_test_model(through)

        app_cache[model._meta.module_name] = model

    return app_cache

def test_proj_sig(*models, **kwargs):
    "Generate a dummy project signature based around a single model"
    version = kwargs.get('version',1)
    proj_sig = {
        'tests': SortedDict(),
        '__version__': version,
    }

    # Compute the project siguature
    for full_name,model in models:
        parts = full_name.split('.')
        if len(parts) == 1:
            name = parts[0]
            app = 'tests'
        else:
            app,name = parts
        proj_sig.setdefault(app, SortedDict())[name] = signature.create_model_sig(model)

    return proj_sig

def execute_transaction(sql, output=False):
    "A transaction wrapper for executing a list of SQL statements"
    try:
        # Begin Transaction
        transaction.enter_transaction_management()
        transaction.managed(True)
        cursor = connection.cursor()

        # Perform the SQL
        if output:
            write_sql(sql)
        execute_sql(cursor, sql)

        transaction.commit()
        transaction.leave_transaction_management()
    except Exception:
        transaction.rollback()
        raise

def execute_test_sql(start, end, sql, debug=False):
    """
    Execute a test SQL sequence. This method also creates and destroys the
    database tables required by the models registered against the test application.

    start and end are the start- and end-point states of the application cache.

    sql is the list of sql statements to execute.

    cleanup is a list of extra sql statements required to clean up. This is
    primarily for any extra m2m tables that were added during a test that won't
    be cleaned up by Django's sql_delete() implementation.

    debug is a helper flag. It displays the ALL the SQL that would be executed,
    (including setup and teardown SQL), and executes the Django-derived setup/teardown
    SQL.
    """
    # Set up the initial state of the app cache
    set_app_test_models(copy.deepcopy(start))

    # Install the initial tables and indicies
    style = no_style()
    execute_transaction(sql_create(evo_test, style), output=debug)
    execute_transaction(sql_indexes(evo_test, style), output=debug)
    create_test_data(models.get_models(evo_test))

    # Set the app cache to the end state
    set_app_test_models(copy.deepcopy(end))

    try:
        # Execute the test sql
        if debug:
            write_sql(sql)
        else:
            execute_transaction(sql, output=True)
    finally:
        # Cleanup the apps.
        if debug:
            print sql_delete(evo_test, style)
        else:
            execute_transaction(sql_delete(evo_test, style), output=debug)

def create_test_data(app_models):
    deferred_models = []
    deferred_fields = {}
    for model in app_models:
        params = {}
        deferred = False
        for field in model._meta.fields:
            if not deferred:
                if type(field) == models.ForeignKey or type(field) == models.ManyToManyField:
                    related_model = field.rel.to
                    if related_model.objects.count():
                        related_instance = related_model.objects.all()[0]
                    else:
                        if field.null == False:
                            # Field cannot be null yet the related object hasn't been created yet
                            # Defer the creation of this model
                            deferred = True
                            deferred_models.append(model)
                        else:
                            # Field cannot be set yet but null is acceptable for the moment
                            deferred_fields[type(model)] = deferred_fields.get(type(model), []).append(field)
                            related_instance = None
                    if not deferred:
                        if type(field) == models.ForeignKey:
                            params[field.name] = related_instance
                        else:
                            params[field.name] = [related_instance]
                else:
                    params[field.name] = DEFAULT_TEST_ATTRIBUTE_VALUES[type(field)]

        if not deferred:
            model(**params).save()

    # Create all deferred models.
    if deferred_models:
        create_test_data(deferred_models)

    # All models should be created (Not all deferred fields have been populated yet)
    # Populate deferred fields that we know about.
    # Here lies untested code!
    if deferred_fields:
        for model, field_list in deferred_fields.items():
            for field in field_list:
                related_model = field.rel.to
                related_instance = related_model.objects.all()[0]
                if type(field) == models.ForeignKey:
                    setattr(model, field.name, related_instance)
                else:
                    getattr(model, field.name).add(related_instance)
            model.save()

def test_sql_mapping(test_field_name):
    sql_for_engine = __import__('django_evolution.tests.db.%s' % (settings.DATABASE_ENGINE), {}, {}, [''])
    return getattr(sql_for_engine, test_field_name)


def deregister_models():
    "Clear the test section of the app cache"
    del cache.app_models['tests']
    clear_models_cache()


def clear_models_cache():
    """Clears the Django models cache.

    This cache is used in Django >= 1.2 to quickly return results from
    cache.get_models(). It needs to be cleared when modifying the model
    registry.
    """
    if hasattr(cache, '_get_models_cache'):
        # On Django 1.2, we need to clear this cache when unregistering models.
        cache._get_models_cache.clear()


def set_app_test_models(models):
    """Sets the list of models in the Django test models registry."""
    cache.app_models['tests'] = models
    clear_models_cache()


def add_app_test_model(model):
    """Adds a model to the Django test models registry."""
    key = model._meta.object_name.lower()
    cache.app_models.setdefault('tests', SortedDict())[key] = model
    clear_models_cache()
