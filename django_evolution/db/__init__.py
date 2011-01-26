# Establish the common EvolutionOperations instance, called evolver.

from django.conf import settings

if settings.DATABASE_ENGINE: # django 1.1 support
    module_name = ['django_evolution.db',settings.DATABASE_ENGINE]
else: # django 1.2 support
    module_name = ['django_evolution.db', settings.DATABASES['default']['ENGINE'].split('.')[3]]

module = __import__('.'.join(module_name),{},{},[''])

evolver = module.EvolutionOperations()

