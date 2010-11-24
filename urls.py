from django.conf.urls.defaults import *

# Uncomment the next two lines to enable the admin:
from django.contrib import admin
admin.autodiscover()

from workouts import views as wod
import settings 

urlpatterns = patterns('',
    #(r'^accounts/login/$', 'django.contrib.auth.views.login', {'template_name': 'login.html'}),
    #(r'^accounts/logout/$', 'django.contrib.auth.views.logout'),
    (r'^accounts/', include('registration.backends.default.urls')),
    (r'^wods/(?P<wodslug>[-\w]+)/(?P<username>w+)/$', wod.single),
    (r'^add/$', wod.add),
    (r'^$', wod.home),
    
    (r'^tagging_autocomplete/', include('tagging_autocomplete.urls')),
    
    (r'^admin/', include(admin.site.urls)),
    
    #/workouts/(slug)/(username)/(dateslug)
    #workouts/(slug)/add
    #/workouts/(slug)
    #/tag/(tag)
    (r'^static/(?P<path>.*)$', 'django.views.static.serve',
        {'document_root': settings.MEDIA_ROOT }),
)
