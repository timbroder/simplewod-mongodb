from django.db import models

# Create your models here.
class Measure(models.Model):
    name = models.CharField(max_length=128)
    
    def __unicode__(self):
        return self.name
    
class MeasureType(models.Model):
    name = models.CharField(max_length=128)
    measures = models.ManyToManyField(Measure)
    
    def __unicode__(self):
        return self.name