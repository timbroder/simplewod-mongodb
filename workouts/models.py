from django.db import models
from django.contrib.auth.models import User
from tagging.models import Tag, TaggedItem
from tagging.taggable import Taggable
from tagging.fields import TagField
import datetime
from sluggable.models import SluggableModel
from django.template.defaultfilters import slugify
from django.contrib.auth.models import User
from django.db.models.signals import post_save
from managers import *

class Workout(SluggableModel, Taggable):
    title = models.CharField(max_length=128, blank=True, null=True)
    workout = models.TextField()
    user = models.ForeignKey(User)
    created_at = models.DateTimeField(auto_now_add=True, default=datetime.datetime.now())
    updated_at = models.DateTimeField(auto_now=True, default=datetime.datetime.now())
    
    objects = WodManager()

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
    
    objects = WodManager()
    
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
    


class UserProfile(models.Model):  
    user = models.ForeignKey(User)
    private_wods = models.BooleanField(default=False)
    #other fields here

    def __str__(self):  
          return "%s's profile" % self.user  

def create_user_profile(sender, instance, created, **kwargs):  
    if created:  
       profile, created = UserProfile.objects.get_or_create(user=instance)  

post_save.connect(create_user_profile, sender=User) 
    
from patch import *