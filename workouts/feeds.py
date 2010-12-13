from django.contrib.syndication.views import Feed
from models import *
from django.shortcuts import get_object_or_404


class WodFeed(Feed):
    title = "simpleWOD.com: Logged Workouts"
    link = "/"
    description = "Workouts added to the site"
    description_template = 'feeds/wod.html'
    
    def items(self):
        return Workout.objects.order_by('-created_at')[:20]
    
    def item_title(self, item):
        return item
    
    def item_description(self, item):
        return item.workout
    
class ResultFeed(Feed):
    title = "simpleWOD.com: Logged Results"
    link = "/"
    description = "Workout Results logged on the site"
    description_template = 'feeds/result.html'
    
    def items(self):
        return Result.objects.order_by('-date')[:20]
    
    def item_title(self, item):
        return item
    
    def item_description(self, item):
        return item.workout
    
class UserFeed(Feed):
    
    description_template = 'feeds/result.html'

    def get_object(self, request, username):
        print username
        #put check for public results in here
        return get_object_or_404(User, username=username)

    def items(self, obj):
        print obj
        return Result.objects.filter(user=obj).order_by('-date')[:20]
    
    def item_title(self, item):
        return item
    
    def item_description(self, item):
        return item.workout
    
    def title(self, obj):
        return "simpleWOD.com: Logged Results by %s" % obj.username
    
    def link(self, obj):
        return "/%s/" % obj.username
    
    def description(self, obj):
        return "Workout Results logged on the site by %s" % obj.username
        
class ProtectedUserFeed(Feed):

    description_template = 'feeds/result.html'

    def get_object(self, request, username, key):
        print username
        print key
        #put check for key  results in here
        return get_object_or_404(User, username=username)

    def items(self, obj):
        print obj
        return Result.objects.filter(user=obj).order_by('-date')[:20]
    
    def item_title(self, item):
        return item
    
    def item_description(self, item):
        return item.workout
    
    def title(self, obj):
        return "simpleWOD.com: Logged Results by %s" % obj.username
    
    def link(self, obj):
        return "/%s/" % obj.username
    
    def description(self, obj):
        return "Workout Results logged on the site by %s" % obj.username