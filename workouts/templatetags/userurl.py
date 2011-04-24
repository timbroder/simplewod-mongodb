from django import template
from django.utils.safestring import mark_safe
from workouts.models import UserProfile

register = template.Library()

@register.filter
def userurl(id):
    profile = UserProfile.objects.get(user__id=id)
    url = "<a href=\"%s\">%s</a>" % (profile.get_absolute_url(), profile.user.username)
    return mark_safe(url)