from django.conf.urls.defaults import *

urlpatterns = patterns('login_as.views',
    url('^$', 'chooser', name='login-as-chooser'),
    url('^(.+?)/$', 'login', name='login-as-login'),
)