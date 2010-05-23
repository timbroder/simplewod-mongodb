from django.contrib.auth.decorators import login_required
from django.shortcuts import render_to_response
from forms import *
from models import *


@login_required
def add(request):
    if request.method == 'POST':
        form = WodForm(request.POST)
        user = request.user
        if form.is_valid():
            w = Workout()
            w.name = form.cleaned_data['name']
            w.user = user
            w.workout = form.cleaned_data['workout']
            w.save()
            r = Result()
            r.user = user
            r.date = form.cleaned_data['date']
            r.workout = w
            r.result = form.cleaned_data['results']
            r.save()
            
            for tag in form.cleaned_data['tags'].split(','):
                r.add_tag(tag)

    else:
        form = WodForm()
        
    return render_to_response('add.html', locals())