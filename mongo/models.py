from django.db import models
from django.core import serializers
import simplejson

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