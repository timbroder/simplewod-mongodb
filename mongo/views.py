from django.contrib.auth.decorators import login_required
from django.shortcuts import render_to_response as r2r
from django.shortcuts import get_object_or_404
from models import *
import time, datetime
from django.core.paginator import Paginator, InvalidPage, EmptyPage
from django.template import RequestContext
import settings
from django.http import HttpResponse
from django.http import HttpResponseRedirect
from django.template import RequestContext, Context
from django.core.mail import send_mail, BadHeaderError
from django.views.decorators.cache import cache_page
from django.contrib.sites.models import Site
from django.http import HttpResponse
from django.utils.datastructures import MultiValueDictKeyError
from django.views.decorators.csrf import csrf_protect
from pymongo import Connection
from django.core import serializers
from django.utils import simplejson


def wods(request):
    return r2r()

@csrf_protect
def add_wod(request):
    return r2r('add0.html')

def add1(request):
    scores = Score.objects.all()
    return r2r('add1.html', locals())

def add2(request):
    print "add2"
    w = MongoWorkout()
    #w.wods.remove()
    print 'm'
    post = request.POST['data']
    print post
    #post =  request.raw_post_data
    #print post
    #validate the json!!!!
    print request.raw_post_data
    w.json = post
    w.user_id = request.user.id
    w.insert()
    #print '1'
    #json = simplejson.loads(request.raw_post_data)
    
    #print '2'
    #print json['data']
    #json = serializers.deserialize("json", json)
    #print json
    #w.wods.insert(json)
    return HttpResponse("Submitted", mimetype='text/plain')
    

def list_exercises(request):
    try:
        exercises = Exercise.objects.filter(name__icontains=request.GET['q']).order_by('name').values_list('name', flat=True)
    except MultiValueDictKeyError:
        exercises = None
        return HttpResponse()
    
    return HttpResponse('\n'.join(exercises), mimetype='text/plain')

def get_ex_type(request):
    #if request.is_ajax():
    print 'yes ajax'
    ex = Exercise.objects.get(name = request.GET['name'])
    return r2r('get_ex_type.html', locals(), context_instance=RequestContext(request))

def get_ex_type_ops(request):
    #if request.is_ajax():
    ex = Exercise.objects.get(name = request.GET['name'])
    return r2r('get_ex_type.html', locals())

def get_wod_json(request):
    try:
        id = request.GET['wod']
    except:
        return HttpResponse({'error': 'wod not found'}, mimetype='application/json')
    json = MongoWorkout.objects.get(mongo_id=id).json
    return HttpResponse(json, mimetype='application/json')


