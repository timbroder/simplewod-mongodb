from django.db import models
from workouts.models import *

#class Calendar(models.Model):
#    user = models.ForeignKey(User)
#    calendar_key = models.CharField(max_length=255, default="", blank=True, null=True)
#    calendar_url = models.CharField(max_length=255, default="", blank=True, null=True)
    
#    def __unicode__(self):
#        return self.user.name
    
#class Assignment(models.Model):
#    user = models.ForeignKey(User)
#    workout = models.ForeignKey(Workout)
#    when = models.DateField()
    
#    def __unicode__(self):
#        return "%s %s" % (self.user.name, self.when)
    
#    def save(self, *args, **kwargs):
#        return super(Result, self).save(*args, **kwargs)


class Day(models.Model):
    day = models.IntegerField()
    
if Day.objects.all().count() == 0:
    i = 1;
    while i <=f 125:
        d = Day()
        d.day = i 
        d.save()
        i = i+1
