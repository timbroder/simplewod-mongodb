from django.conf.urls.defaults import *
from django.http import HttpResponsePermanentRedirect

from mongo import views as mongo
import settings

urlpatterns = patterns('',
    (r'^wods/$', mongo.wods),
    (r'^wods/add/$', mongo.add_wod),
    (r'^ajax/add1/$', mongo.add1),
    (r'^ajax/add2/$', mongo.add2),
    (r'^ajax/list_exercises/$', mongo.list_exercises),
    (r'^ajax/get_ex/$', mongo.get_ex_type),
    (r'^ajax/get_ex_type_ops/$', mongo.get_ex_type_ops),
    (r'^ajax/get_wod.json/$', mongo.get_wod_json),
)
 