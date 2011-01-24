from django.conf.urls.defaults import *
from django.http import HttpResponsePermanentRedirect

from mongo import views as mongo
import settings

urlpatterns = patterns('',
    (r'^wods/$', mongo.wods),
    (r'^wods/add/$', mongo.add_wod),
    (r'^ajax/add1/$', mongo.add1),
)
 