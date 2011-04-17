from django.db import models
from django.core import serializers
import simplejson
from workouts.models import Workout, Result
from pymongo import json_util
import json as jlib
from settings import DB
from pymongo.objectid import ObjectId

# Create your models here.
class Measure(models.Model):
    name = models.CharField(max_length=128)
    
    def __unicode__(self):
        return self.name
    
    class Meta:
        ordering = ['name']
    
class MeasureType(models.Model):
    name = models.CharField(max_length=128)
    measures = models.ManyToManyField(Measure)
    #django_id = models.IntegerField(blank=True, null=True)
    has_reps = models.BooleanField(default=True)
    
    def __unicode__(self):
        return self.name
    
    def save(self, *args, **kwargs):
        #if not self.id:
        #    self.django_id = 0
        return super(MeasureType,self).save(*args, **kwargs)
        #self.django_id = self.id
        #print self.django_id
        #json =  serializers.serialize('json', [self])[1:-1]
        #print json
        #json = simplejson.loads(json)
        #print json
        #print object_hook
        #print as_complex
        #return json
        
class Exercise(models.Model):
    name = models.CharField(max_length=128)
    type = models.ManyToManyField(MeasureType)
    
    #full json 
    #serializers.serialize('json', [Exercise.objects.all()[0]], indent=4, relations={'type': {'relations': ('measures',)}})
    
    def __unicode__(self):
        return self.name
    
    class Meta:
        ordering = ['name']

class MongoConnection(object):
    
    def __init__(self, *args, **kwargs):
        print 'init mongoconn'
        self.wods = DB.wods
        self.results = DB.results
        
        
        return super(MongoConnection,self).__init__(*args, **kwargs)  
        
class MongoWorkout(MongoConnection, Workout):
    json = models.TextField()
    mongo_id = models.CharField(max_length=32, unique=True)
    
    def insert(self, json=None):
        if not json:
            json = self.json
        if not self.json:
            raise Exception
        json = simplejson.loads(json)
        print json
        self.title = json['name']
        print self.title
        self.save()
        #self.wods.remove()
        
        load = jlib.loads(self.json)
        load['django_id'] = self.id
        load['user_id'] = self.user_id
        load['slug'] = self.slug

        self.mongo_id = self.wods.insert(load)
        self.save()
    
    def get(self):
        return self.wods.find_one({"_id": ObjectId(self.mongo_id)})

class MongoResult(MongoConnection, Workout):
    json = models.TextField()
    mongo_id = models.CharField(max_length=32, unique=True)
    
    def insert(self, json=None):
        if not json:
            json = self.json
        if not self.json:
            raise Exception
        json = simplejson.loads(json)
        print json
        self.save()
        #self.wods.remove()
        
        load = jlib.loads(self.json)
        load['django_id'] = self.id
        load['user_id'] = self.user_id
        load['slug'] = self.slug

        self.mongo_id = self.results.insert(load)
        self.save()

class ScoreExample(models.Model):
    name = models.CharField(max_length=64)
    url= models.URLField(verify_exists=True, max_length=255)
    
    def __unicode__(self):
        return self.name
       
class Score(models.Model):
    name = models.CharField(max_length=64)
    measure = models.ManyToManyField(MeasureType)
    example = models.ManyToManyField(ScoreExample, blank=True, null=True)
    input_test = models.CharField(max_length=64)
    clazz = models.CharField(max_length=32, default="")
    help = models.TextField(blank=True, null=True)
    
    def __unicode__(self):
        return self.name
    

    
