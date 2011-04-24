from django.contrib.auth.decorators import login_required
from django.shortcuts import render_to_response as r2r
from django.shortcuts import get_object_or_404
from forms import *
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
from mongo.models import *
from mongo.views import *
from settings import DB
from pymongo.objectid import ObjectId
from django.utils.encoding import smart_unicode
from django.core import serializers

debug = getattr(settings, 'DEBUG', None)

def get_paginator(request, qs, num=20):
    if debug:
        print '- get paginator'
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
    if debug:
        print '- fix tags'
        
    print tags
    tags = tags.replace(' ', '-')
    tags = tags.split(',')
    tt = []
    for t in tags:
        if len(t) > 0:
            if t[0] == '-':
                t = t[1:]
            tt.append(t)
    tt = ','.join(tt)
    print "t3"
    print tt
    return tt    

@login_required
def add_wod(request):
    if debug:
        print '- add wod'
        
    user = request.user
    if request.method == 'POST':
        print request.POST
        form = WodForm(request.POST)
        
        if form.is_valid():
            w = Workout()
            w.title = form.cleaned_data['name']
            w.user = user
            w.workout = form.cleaned_data['workout']
            w.save()
            w.set_tags(fix_tags(form.cleaned_data['wod_tags']))
            print w.id
            
            if form.cleaned_data.get('has_result', False):
                print 'storing result    '
                r = Result()
                r.user = user
                tempdate = form.cleaned_data['date']
    
                tempdate = time.strptime(tempdate,"%m/%d/%Y")
                r.date = time.strftime("%Y-%m-%d",tempdate)
    
                r.workout = w
                r.result = form.cleaned_data['results']
                r.time = form.cleaned_data['time']
                r.weight = form.cleaned_data['weight']
                r.notes = form.cleaned_data['notes']
                r.save()
                
                #for tag in form.cleaned_data['tags'].split(','):
                    #r.add_tag(tag)
                print form.cleaned_data['tags']
                print "1!!!!!!!"
                rtags = "%s, %s" % (fix_tags(form.cleaned_data['wod_tags']), fix_tags(form.cleaned_data['tags']))
                print rtags
                r.set_tags(rtags)
                #print form.cleaned_data['wod_tags']
                #print fix_tags(form.cleaned_data['wod_tags'])
                print "2!!!!!!!"
                #r.set_tags(fix_tags(form.cleaned_data['tags']))
            
            
            #w.set_tags(form.cleaned_data['tags'].replace(' ', '_'))
            print 'posting'
            posted = True
        else:
            print 'not valid?'
            
    else:
        form = WodForm(initial={'date': datetime.datetime.now().strftime("%m/%d/%Y"), 'has_result': True})
        #form.date = datetime.datetime.now().strftime("%d/%m/%Y")
        
        
    return r2r('add.html', locals(), context_instance=RequestContext(request))

def result_add(request, wodslug):
    if debug:
        print '- result add'
        
    return r2r('add_result.html', locals())


#@cache_page(60 * 60 * 2)
def home(request):
    if debug:
        print "home"
    user = request.user
    r1 = MongoWorkout.objects.all().order_by('-touched_at')
    #r1 = Workout.private_objects.all().order_by('-created_at')
    #if user.is_authenticated() and user.get_profile().private_wods:
    #    r2 = Workout.objects.filter(user=user).order_by('-created_at')
    #    results = get_paginator(request, r1 | r2)
    #else:
    #    results = get_paginator(request, r1)
    results = get_paginator(request, r1, 20)
    tag_cloud_template = 'tags_home.html'
    title = 'Recent Workouts'
    
    #exes = Exercise.objects.all().order_by('name')
    exes = serializers.serialize("json", Exercise.objects.all().order_by('name'))
    print exes
    show = True
    home = True
    return r2r('index.html', locals())

#@cache_page(60 * 60 * 2)
def home_user(request, username):
    if debug:
        print '- home user'
        
    user = get_object_or_404(User, username=username)
    show = False
    if user.get_profile().private_wods:
        if request.user == user:
            show = True
    else:
        show = True
    
    results = get_paginator(request, Result.objects.filter(user=user).order_by('-date'), 20)
    tag_cloud_template = 'tags_home_user.html'
    header = "%s's Recent Workouts" % username
    title = username
    return r2r('index.html', locals())

#@cache_page(60 * 60 * 2)
def wod_single(request, wodslug):
    if debug:
        print '- wods single'
    user = request.user
    wod = MongoWorkout.objects.get(slug = wodslug)
    print wod
    print wod.mongo_id
    
    mwod = wod.get()
    print mwod['_id']
    
    print 'res'
    results = MongoResult.private_objects.filter(workout = wod).order_by('-updated_at')
    #results = DB.results.find(wod=ObjectId(mwod['_id']))
    print results
    
    if user.is_authenticated() and user.get_profile().private_wods:
        r2 = MongoResult.objects.filter(workout = wod, user=user).order_by('-updated_at')
        #results = results | r2
    
    results = map(ObjectId, results.values_list('mongo_id', flat=True))
    print results
    #for r in results:
    #    r = ObjectId(r)
    #({j:{$in: [2,4,6]}});
    results = DB.results.find({"_id": { "$in": results }})
    
    print results
    #<pymongo.cursor.Cursor object at 0x102a2fe50>
    rr = results
    #for r in results:
    #    print r['user_id']
    #    rr.append(r)
    #rr = [(r['user_id'],) for r in results.collection]
    print rr
    #prints expected user id
    
    
    return r2r('singlewod.html', {'results': rr, 'mwod': mwod, 'wod': wod, 'request': request})

#@cache_page(60 * 60 * 2)
def result_single(request, wodslug, username):
    if debug:
        print '- result single'
        
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

#@cache_page(60 * 60 * 2)
def result_tag_user(request, username, tagslug):
    if debug:
        print '- result tag user'
        
    user = get_object_or_404(User, username=username)
    results = TaggedItem.objects.get_by_model(Result, tagslug).order_by('-date')
    if (request.user.is_authenticated() and request.user.get_profile().private_wods) or not user.get_profile().private_wods:
        results = results.filter(user=user)
        show = True
    
    results = get_paginator(request, results, 10)
    
    if request.user.is_authenticated() and request.user.username == username:
        message = 'You have not logged any results with this tag'
    
    header = "Tagged Results: %s" % Tag.objects.get(name=tagslug)
    user = request.user
    return r2r('tagresult.html', locals())

#@cache_page(60 * 60 * 2)
def result_tag(request, tagslug):
    if debug:
        print '- result tag'
        
    results = TaggedItem.objects.get_by_model(Result, tagslug).order_by('-date')
    header = "Tagged Results: %s" % Tag.objects.get(name=tagslug)
    user = request.user
    return r2r('singleresult.html', locals())

#@cache_page(60 * 60 * 2)
def wod_tag(request, tagslug):
    if debug:
        print '- wod tag'
        
    results = get_paginator(request, TaggedItem.objects.get_by_model(Workout, tagslug).order_by('-created_at'), 10)
    print Workout.objects.all().order_by('-created_at')
    header = "Tagged Workouts: %s" % Tag.objects.get(name=tagslug)
    user = request.user
    return r2r('tagwod.html', locals())

#@cache_page(60 * 60 * 2)
def result_add_ajax_form(request):
    if debug:
        print '- ajax add form'
        
    wod_id = request.GET.get('wod_id')
    if request.is_ajax() and wod_id:
        action = 'add/'
        tags = Workout.objects.get(id=wod_id).get_tags()
        
        if request.method == 'POST':
            print 'post'
            form = ResultFormAjax(request.POST)
        else:
            form = ResultFormAjax()
        print form
        return r2r('resultform.html', locals(), context_instance=RequestContext(request))
    
def result_add_form(request, wodslug):
    if debug:
        print '- in result add form'
        
    wod_id = request.GET.get('wod_id')
    print request.POST
    wod = get_object_or_404(Workout, slug=wodslug)
    tags = Workout.objects.get(id=wod.id).get_tags()
    action = ''
    user = request.user
    if request.method == 'POST':
        print 'post'
        form = ResultFormAdd(request.POST)
        if form.is_valid():
            print "VALID"
            r = Result()
            r.user = user
            tempdate = form.cleaned_data['date']

            tempdate = time.strptime(tempdate,"%m/%d/%Y")
            r.date = time.strftime("%Y-%m-%d",tempdate)

            r.workout = wod
            r.result = form.cleaned_data['results']
            r.time = form.cleaned_data['time']
            r.weight = form.cleaned_data['weight']
            r.notes = form.cleaned_data['notes']
            r.save()
            
            #for tag in form.cleaned_data['tags'].split(','):
                #r.add_tag(tag)
            print form.cleaned_data['tags']
            tt = []
            for tag in wod.get_tags():
                tt.append(tag.name)
            r.set_tags(", ".join(tt))
            r.set_tags(fix_tags(form.cleaned_data['tags']))
            submitted = True
        else:
            print 'crap'
    else:
       form = ResultFormAdd()

    return r2r('addresult.html', locals(), context_instance=RequestContext(request))

@login_required
def settings(request):
    user = request.user
    if request.method == 'POST':
        form = SettingsForm(request.POST)
        if form.is_valid():
            user.email = form.cleaned_data['email']
            user.get_profile().private_wods = form.cleaned_data['private_wods']
            
            user.save()
            user.get_profile().save()
            posted = True
    else:
        form = SettingsForm(initial={'email': user.email, 'private_wods': user.get_profile().private_wods})
    
    return r2r('settings.html', locals(), context_instance=RequestContext(request))

#@cache_page(60 * 60 * 2)
def contactview(request):
    if debug:
        print 'contactview'
    if request.method == 'POST':
        form = ContactForm(request.POST)
        if form.is_valid():
            if debug:
                'valid form'
            subject = "simpleWOD contact: %s" % form.cleaned_data['topic']
            message = "From: %s\n\n%s" % (form.cleaned_data['name'], form.cleaned_data['message'])
            from_email = form.cleaned_data['email']
            try:
                send_mail(subject, message, from_email, ['timothy.broder@gmail.com'])
            except BadHeaderError:
                    return HttpResponse('Invalid header found.')
            return HttpResponseRedirect('/contact/thankyou/')
    else:        
        form = ContactForm()
        #form = ContactForm(initial={'topic': 'simpleWOD contact form submission' })


    return r2r('contact.html', locals(), context_instance=RequestContext(request))

def thankyou(request):
        return render_to_response('thankyou.html')
    
def feeds(request):
    user = request.user
    domain = 'http://%s/' % Site.objects.get_current().domain

    return r2r('feeds.html', locals())

 
    
