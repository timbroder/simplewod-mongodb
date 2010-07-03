from django import forms
from django.forms.extras.widgets import SelectDateWidget
import datetime
from tagging.forms import TagField
from tagging_autocomplete.widgets import TagAutocomplete

class WodForm(forms.Form):
    name = forms.CharField(required=False)
    date = forms.CharField()#forms.DateField(widget=SelectDateWidget(), initial=datetime.date.today())
    workout = forms.CharField(widget=forms.Textarea)
    results = forms.CharField(widget=forms.Textarea)
    tags = TagField(widget=TagAutocomplete())
    