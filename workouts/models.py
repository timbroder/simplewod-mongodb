from django.db import models
from django.contrib.auth.models import User
from tagging.models import Tag, TaggedItem
from tagging.taggable import Taggable
from tagging.fields import TagField
import datetime
from sluggable.models import SluggableModel
from django.template.defaultfilters import slugify

class Workout(SluggableModel, Taggable):
    title = models.CharField(max_length=128, blank=True, null=True)
    workout = models.TextField()
    user = models.ForeignKey(User)
    created_at = models.DateTimeField(auto_now_add=True, default=datetime.datetime.now())
    updated_at = models.DateTimeField(auto_now=True, default=datetime.datetime.now())

    def save(self, *args, **kwargs):
        if self.title == None or self.title == "":
            self.title = datetime.date.today().strftime("%A, %B %d, %Y")
        super(Workout,self).save(*args, **kwargs)
        
    def __unicode__(self):
        return self.title
    
    def get_absolute_url(self):
        return "/wods/%s" % self.slug

        
class Result(Taggable):
    workout = models.ForeignKey(Workout)
    date = models.DateField()
    dateslug = models.CharField(max_length=16, blank=True, null=True)
    result = models.TextField()
    notes = models.TextField(blank=True, null=True)
    user = models.ForeignKey(User)
    created_at = models.DateTimeField(auto_now_add=True, default=datetime.datetime.now())
    updated_at = models.DateTimeField(auto_now=True,  default=datetime.datetime.now())
    
    def __unicode__(self):
        return "%s - %s - %s" % (self.workout, self.user, self.date)
    
    def save(self, *args, **kwargs):
        self.dateslug = slugify(self.date)
        return super(Result, self).save(*args, **kwargs)
    
    def get_absolute_url(self):
        #return "%s/%s/%s/" % (self.workout.get_absolute_url(), self.user.username, self.dateslug)
        return "/%s%s" % (self.user.username, self.workout.get_absolute_url())
    
    def get_add_url(self):
        return "%s/add" % self.workout.get_absolute_url()
    
from patch import *