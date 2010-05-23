from django import forms
from django.forms.extras.widgets import SelectDateWidget
import datetime

class WodForm(forms.Form):
    name = forms.CharField(required=False)
    date = forms.DateField(widget=SelectDateWidget(), initial=datetime.date.today())
    workout = forms.CharField(widget=forms.Textarea)
    results = forms.CharField(widget=forms.Textarea)
    tags = forms.CharField()
    