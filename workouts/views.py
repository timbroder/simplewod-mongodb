from django.contrib.auth.decorators import login_required
from django.shortcuts import render_to_response as r2r
from django.shortcuts import get_object_or_404
from forms import *
from models import *
import time, datetime
from django.core.paginator import Paginator, InvalidPage, EmptyPage
from django.template import RequestContext



def get_paginator(request, qs, num=10):
    #post_list = qs

    paginator = Paginator(qs, num)
    try:
        page = int(request.GET.get('page', '1'))
    except ValueError:
        page = 1

    try:
        results = paginator.page(page)
    except (EmptyPage, InvalidPage):
        results    = paginator.page(paginator.num_pages)
    
    return results



def fix_tags(tags):
    tags = tags.replace(' ', '-')
    tags = tags.split(',')
    tt = []
    for t in tags:
        if len(t) > 0:
            if t[0] == '-':
                t = t[1:]
            tt.append(t)
    tt = ','.join(tt)
    return tt    

@login_required
def add_wod(request):
    user = request.user
    if request.method == 'POST':
        form = WodForm(request.POST)
        
        if form.is_valid():
            w = Workout()
            w.title = form.cleaned_data['name']
            w.user = user
            w.workout = form.cleaned_data['workout']
            w.save()
            print w.id
            r = Result()
            r.user = user
            tempdate = form.cleaned_data['date']

            tempdate = time.strptime(tempdate,"%m/%d/%Y")
            r.date = time.strftime("%Y-%m-%d",tempdate)

            r.workout = w
            r.result = form.cleaned_data['results']
            r.save()
            
            #for tag in form.cleaned_data['tags'].split(','):
                #r.add_tag(tag)
            print form.cleaned_data['tags']
            r.set_tags(fix_tags(form.cleaned_data['tags']))
            #w.set_tags(form.cleaned_data['tags'].replace(' ', '_'))
            posted = True
            
    else:
        form = WodForm(initial={'date': datetime.datetime.now().strftime("%m/%d/%Y")})
        #form.date = datetime.datetime.now().strftime("%d/%m/%Y")
        
        
    return r2r('add.html', locals(), context_instance=RequestContext(request))

def result_add(request, wodslug):
    return r2r('add_result.html', locals())
    
def home(request):
    print "home"
    user = request.user
    r1 = Workout.objects.all().order_by('-created_at')
    #r1 = Workout.private_objects.all().order_by('-created_at')
    #if user.is_authenticated() and user.get_profile().private_wods:
    #    r2 = Workout.objects.filter(user=user).order_by('-created_at')
    #    results = get_paginator(request, r1 | r2)
    #else:
    #    results = get_paginator(request, r1)
    results = get_paginator(request, r1)
    tag_cloud_template = 'tags_home.html'
    title = 'Home'
    show = True
    return r2r('index.html', locals())

def home_user(request, username):
    user = get_object_or_404(User, username=username)
    if user.get_profile().private_wods:
        if request.user == user:
            show = True
    else:
        show = True
    
    results = get_paginator(request, Result.objects.filter(user=user).order_by('-date'))
    tag_cloud_template = 'tags_home_user.html'
    header = "%s's Recent Workouts" % username
    title = username
    return r2r('index.html', locals())

def wod_single(request, wodslug):
    print "wods single"
    user = request.user
    wod = Workout.objects.get(slug = wodslug)
    
    results = Result.private_objects.filter(workout = wod).order_by('-date')
    print results
    print "!"
    if user.is_authenticated() and user.get_profile().private_wods:
        r2 = Result.objects.filter(workout = wod, user=user).order_by('-date')
        results = results | r2
    
    print results
    return r2r('singlewod.html', locals())

def result_single(request, wodslug, username):
    user = get_object_or_404(User, username=username)
    wod = get_object_or_404(Workout, slug=wodslug)
    #results = Result.private_objects.filter(workout__slug=wodslug, user=user)
    print "2"
    print user.is_authenticated()
    print user.get_profile().private_wods
    
    if (request.user.is_authenticated() and request.user.get_profile().private_wods) or not user.get_profile().private_wods:
        
        results = Result.objects.filter(workout = wod, user=user).order_by('-date')
        show = True
        print results
    return r2r('singleresult.html', locals())

def result_tag_user(request, username, tagslug):
    user = get_object_or_404(User, username=username)
    results = TaggedItem.objects.get_by_model(Result, tagslug).order_by('-date')
    if (request.user.is_authenticated() and request.user.get_profile().private_wods) or not user.get_profile().private_wods:
        results = results.filter(user=user)
        show = True
    print "3"
    print user.get_profile().private_wods
    print results
    header = "Tag: %s" % Tag.objects.get(name=tagslug)
    user = request.user
    return r2r('singleresult.html', locals())

def result_tag(request, tagslug):
    results = TaggedItem.objects.get_by_model(Result, tagslug).order_by('-date')
    header = "Tag: %s" % Tag.objects.get(name=tagslug)
    user = request.user
    return r2r('singleresult.html', locals())

def wod_tag(request, tagslug):
    results = TaggedItem.objects.get_by_model(Workout, tagslug).order_by('-created_at')
    print Workout.objects.all().order_by('-created_at')
    header = "Tag: %s" % Tag.objects.get(name=tagslug)
    user = request.user
    return r2r('tagwod.html', locals())

def result_add_ajax_form(request):
    print 'in ajax add form'
    wod_id = request.GET.get('wod_id')
    if request.is_ajax() and wod_id:
        
        tags = Workout.objects.get(id=wod_id).get_tags()
        
        if request.method == 'POST':
            print 'post'
            form = ResultFormAjax(request.POST)
        else:
            form = ResultFormAjax()
        print form
        return r2r('resultform.html', locals())
    