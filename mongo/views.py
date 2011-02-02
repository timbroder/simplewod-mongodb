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

def wods(request):
    return r2r()

def add_wod(request):
    return r2r('add0.html')

def add1(request):
    return r2r('add1.html', context_instance=RequestContext(request))

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

