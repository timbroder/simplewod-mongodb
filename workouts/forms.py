from django import forms
from django.forms.extras.widgets import SelectDateWidget
import datetime
from tagging.forms import TagField
from tagging_autocomplete.widgets import TagAutocomplete

class WodForm(forms.Form):
    name = forms.CharField(required=False)
    workout = forms.CharField(widget=forms.Textarea)
    has_result = forms.BooleanField(initial=True, widget=forms.HiddenInput)
    date = forms.CharField(required=False)#forms.DateField(widget=SelectDateWidget(), initial=datetime.date.today())    
    results = forms.CharField(widget=forms.Textarea, required=False)
    tags = TagField(widget=TagAutocomplete())
    