from django.contrib.auth.decorators import login_required
from django.shortcuts import render_to_response as r2r
from forms import *
from models import *
import time, datetime

def home(request):
    results = Result.objects.all()
    #if request.user.is_authenticated():
    #    results = results.filter(user=user)
    results = results.order_by('-date')[:10]
    
    return r2r('index.html', locals())
@login_required
def add(request):
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
            r.set_tags(form.cleaned_data['tags'].replace(' ', '_'))
            #w.set_tags(form.cleaned_data['tags'].replace(' ', '_'))
            posted = True

    else:
        form = WodForm(initial={'date': datetime.datetime.now().strftime("%m/%d/%Y")})
        #form.date = datetime.datetime.now().strftime("%d/%m/%Y")
        
        
    return r2r('add.html', locals())

def wod_single(request, wodslug, username, dateslug):
    results = Result.objects.filter(workout__slug = wodslug, user__username = username, dateslug = dateslug).order_by('-date')
    return r2r('singleresult.html', locals())

def result_tag(request, tagslug):
    print tagslug
    results = TaggedItem.objects.get_by_model(Result, tagslug).order_by('-date')
    return r2r('tagresult.html', locals())
    