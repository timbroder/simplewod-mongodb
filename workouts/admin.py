from django.contrib import admin
from models import *

class WorkoutAdmin(admin.ModelAdmin):
    search_fields = ('title', 'workout', 'created_at',)
    #index = 'sayin_post'
    #list_filter = ('title', 'created_at',)
    list_display = ('title', 'slug', 'created_at', 'touched_at', 'user')
    ordering = ('-created_at',)
    
class ResultAdmin(admin.ModelAdmin):
    #search_fields = ('title', 'workout', 'created_at',)
    #index = 'sayin_post'
    #list_filter = ('title', 'created_at',)
    list_display = ('__unicode__', 'date')
    ordering = ('-date',)

admin.site.register(Workout, WorkoutAdmin)
admin.site.register(Result, ResultAdmin)
admin.site.register(UserProfile)