from django.db import models

class WodManager(models.Manager):
    def get_query_set(self):
        return super(WodManager, self).get_query_set().filter(user__userprofile__private_wods=False)