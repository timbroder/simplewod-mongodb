from django import forms
from django.forms.extras.widgets import SelectDateWidget
import datetime
from django.contrib.admin.widgets import AdminTimeWidget,AdminDateWidget 

class WodForm(forms.Form):
    name = forms.CharField(required=False)
    date = forms.CharField()#forms.DateField(widget=SelectDateWidget(), initial=datetime.date.today())
    workout = forms.CharField(widget=forms.Textarea)
    results = forms.CharField(widget=forms.Textarea)
    tags = forms.CharField(required=False)
    