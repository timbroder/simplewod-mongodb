from django.contrib.auth.decorators import login_required
from django.shortcuts import render_to_response as r2r
from forms import *
from models import *
import time, datetime

def home(request):
    results = Result.objects.all()
    #if request.user.is_authenticated():
    #    results = results.filter(user=user)
    results = results.order_by('-date')
    
    return r2r('index.html', locals())

def fix_tags(tags):
    tags = tags.replace(' ', '-')
    tags = tags.split(',')
    tt = []
    
    for t in tags:
        if t[0] == '-':
            t = t[1:]
        print t
        tt.append(t)
    tt = ','.join(tt)
    print tt
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
        
        
    return r2r('add.html', locals())

def result_add(request, wodslug):
    return r2r('add_result.html', locals())
    
def wod_single(request, wodslug, username, dateslug):
    results = Result.objects.filter(workout__slug = wodslug, user__username = username, dateslug = dateslug).order_by('-date')
    return r2r('singleresult.html', locals())

def result_tag(request, tagslug):
    results = TaggedItem.objects.get_by_model(Result, tagslug).order_by('-date')
    header = "Tag: %s" % Tag.objects.get(name=tagslug)
    return r2r('singleresult.html', locals())
    