from django.db import models
from django.contrib.auth.models import User
from tagging.models import Tag, TaggedItem
from tagging.fields import TagField
import datetime
from sluggable.models import SluggableModel
from django.template.defaultfilters import slugify

class Taggable(models.Model):
    tags = models.CharField(max_length=255, blank=True, null=False)

    def get_tags(self):
        return Tag.objects.get_for_object(self) 
    
    def set_tags(self, tag_list):
        Tag.objects.update_tags(self, tag_list)
    
    def add_tag(self, tag):
        Tag.objects.add_tag(self, tag)
        
    def get_related_by_tag(self):
        return TaggedItem.objects.get_related(self, self.__class__, num=5)
    
    def remove_tag(self, tag):
        tags = self.get_tags()
        tags = tags.exclude(name=tag)
        self.set_tags(','.join(['"%s"' % t.name for t in tags]))
        
    class Meta:
        abstract = True

class Workout(SluggableModel):
    title = models.CharField(max_length=128, blank=True, null=True)
    workout = models.TextField()
    user = models.ForeignKey(User) 

    def save(self, *args, **kwargs):
        if self.title == None or self.title == "":
            self.title = datetime.date.today().strftime("%A, %B %d, %Y")
        super(Workout,self).save(*args, **kwargs)
        
    def __unicode__(self):
        return self.title
    
    def get_absolute_url(self):
        return "/workouts/%s" % self.slug

        
class Result(Taggable):
    workout = models.ForeignKey(Workout)
    date = models.DateField()
    dateslug = models.CharField(max_length=16, blank=True, null=True)
    result = models.TextField()
    notes = models.TextField(blank=True, null=True)
    user = models.ForeignKey(User)
    
    def __unicode__(self):
        return "%s - %s - %s" % (self.workout, self.user, self.date)
    
    def save(self, *args, **kwargs):
        self.dateslug = slugify(self.date)
        return super(Result, self).save(*args, **kwargs)
    
    def get_absolute_url(self):
        return "%s/%s/%s/" % (self.workout.get_absolute_url(), self.user.username, self.dateslug)
    
    def get_add_url(self):
        return "%s/add" % self.workout.get_absolute_url()