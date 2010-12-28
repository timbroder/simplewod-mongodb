from django.conf.urls.defaults import *

# Uncomment the next two lines to enable the admin:
from django.contrib import admin
admin.autodiscover()

from workouts import views as wod
from workouts.feeds import *
import settings 

urlpatterns = patterns('',
    #(r'^accounts/login/$', 'django.contrib.auth.views.login', {'template_name': 'login.html'}),
    #(r'^accounts/logout/$', 'django.contrib.auth.views.logout'),
    (r'^accounts/', include('registration.backends.default.urls')),
   
    ##(r'^wods/(?P<tagslug>.+)/$', wod.wod_tag),
    (r'^settings/$', wod.settings),
    (r'^contact/thankyou/', wod.thankyou),
    (r'^contact/', wod.contactview),

    (r'^ajax/addresultform/$', wod.result_add_ajax_form),
    (r'^wods/add/$', wod.add_wod),
    (r'^wods/feed/$', WodFeed()),
    (r'^wods/tag/(?P<tagslug>.+)/$', wod.wod_tag),
    (r'^wods/(?P<wodslug>.+)/add/$', wod.result_add_form),
    (r'^wods/(?P<wodslug>.+)/$', wod.wod_single),
    (r'^results/feed/$', ResultFeed()),
    (r'^(?P<username>.+)/feed/(?P<key>.+)/$', ProtectedUserFeed()),
    (r'^(?P<username>.+)/feed/$', UserFeed()),
    (r'^results/tag/(?P<tagslug>.+)/$', wod.result_tag),
    
    (r'^results/add/(?P<wodslug>.+)/$', wod.result_add),
    (r'^(?P<username>.+)/tag/(?P<tagslug>.+)/$', wod.result_tag_user),
    (r'^(?P<username>.+)/wods/(?P<wodslug>.+)/$', wod.result_single),
    
    
    (r'^tagging_autocomplete/', include('tagging_autocomplete.urls')),
    (r'^admin/', include(admin.site.urls)),    
    
    
    
    
    
     (r'^(?P<username>.+)/$', wod.home_user),
    (r'^$', wod.home),
    

    
    #/workouts/(slug)/(username)/(dateslug)
    #workouts/(slug)/add
    #/workouts/(slug)
    #/tag/(tag)
    
    (r'^static/(?P<path>.*)$', 'django.views.static.serve',
        {'document_root': settings.MEDIA_ROOT }),
)
