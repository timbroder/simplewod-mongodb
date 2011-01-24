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

def wods(request):
    return r2r()

def add_wod(request):
    return r2r('add0.html')

def add1(request):
    return r2r('add1.html')