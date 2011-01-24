# Django settings for mongomode project.

DEBUG = True
TEMPLATE_DEBUG = DEBUG

ADMINS = (
    # ('Your Name', 'your_email@domain.com'),
)

MANAGERS = ADMINS

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'logger',
        'USER': 'root',
        'PASSWORD': 'root'
    }
}

# Local time zone for this installation. Choices can be found here:
# http://en.wikipedia.org/wiki/List_of_tz_zones_by_name
# although not all choices may be available on all operating systems.
# If running in a Windows environment this must be set to the same as your
# system time zone.
TIME_ZONE = 'America/New_York'

# Language code for this installation. All choices can be found here:
# http://www.i18nguy.com/unicode/language-identifiers.html
LANGUAGE_CODE = 'en-us'

SITE_ID = 1

# If you set this to False, Django will make some optimizations so as not
# to load the internationalization machinery.
USE_I18N = True

# Absolute path to the directory that holds media.
# Example: "/home/media/media.lawrence.com/"
MEDIA_ROOT = '/Users/localadmin/workspace/simplewod/static'

# URL that handles the media served from MEDIA_ROOT. Make sure to use a
# trailing slash if there is a path component (optional in other cases).
# Examples: "http://media.lawrence.com", "http://example.com/media/"
MEDIA_URL = ''
#TAGGING_AUTOCOMPLETE_JS_BASE_URL = '/static/js/jquery.autocomplete.min.js'

# URL prefix for admin media -- CSS, JavaScript and images. Make sure to use a
# trailing slash.
# Examples: "http://foo.com/media/", "/media/".
ADMIN_MEDIA_PREFIX = '/media/'

# Make this unique, and don't share it with anybody.
SECRET_KEY = '4y-#1o7i!n*e21n1zw!h6g17c23xrkec39!vak#s)*d+m7g+70'
ACCOUNT_ACTIVATION_DAYS = 7

# List of callables that know how to import templates from various sources.
TEMPLATE_LOADERS = (
    'django.template.loaders.filesystem.load_template_source',
    'django.template.loaders.app_directories.load_template_source',
#     'django.template.loaders.eggs.load_template_source',
)

MIDDLEWARE_CLASSES = (
    'django.middleware.common.CommonMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'facebook.djangofb.FacebookMiddleware',
    'facebookconnect.middleware.FacebookConnectMiddleware',
    #'socialregistration.middleware.FacebookMiddleware',
    'debug_toolbar.middleware.DebugToolbarMiddleware',
)

AUTHENTICATION_BACKENDS = (
    'facebookconnect.models.FacebookBackend',
    #'socialregistration.auth.FacebookAuth',
    'django.contrib.auth.backends.ModelBackend',
)

ROOT_URLCONF = 'urls'
CACHE_BACKEND = 'db://cache'
INSTALLED_APPS = (
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.sites',
    'django.contrib.admin',
    'registration',
    'workouts',
    'tagging',
    'django_evolution',
    'django_extensions',
    'sluggable',
    'tagging_autocomplete',
    'facebookconnect',
    'debug_toolbar',
    #'socialregistration'
    'mongo',
)

INTERNAL_IPS = ('127.0.0.1',)
AUTH_PROFILE_MODULE = 'workouts.UserProfile'


TEMPLATE_CONTEXT_PROCESSORS = ("django.core.context_processors.auth",
    "django.core.context_processors.debug",
    "django.core.context_processors.i18n",
    "django.core.context_processors.media",
#    "django.core.context_processors.request",
    "workouts.context_processors.user",
)

DUMMY_FACEBOOK_INFO = {
    'uid':0,
    'name':'(Private)',
    'first_name':'(Private)',
    'pic_square_with_logo':'http://www.facebook.com/pics/t_silhouette.gif',
    'affiliations':None,
    'status':None,
    'proxied_email':None,
}




FACEBOOK_API_KEY = '00000000000000000000000000000000'
FACEBOOK_SECRET_KEY = '00000000000000000000000000000000'
FACEBOOK_INTERNAL = True

#try:
from local_settings import *
#except ImportError:
#pass
