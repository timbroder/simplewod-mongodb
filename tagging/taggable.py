from django.db import models
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