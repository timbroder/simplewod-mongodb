from django import forms
from django.forms.extras.widgets import SelectDateWidget
import datetime
from tagging.forms import TagField
from tagging_autocomplete.widgets import TagAutocomplete

result_required = "If you are adding a result, this field is required"

class WodForm(forms.Form):
    name = forms.CharField(required=False)
    workout = forms.CharField(widget=forms.Textarea, required=True)
    has_result = forms.BooleanField(initial=True, widget=forms.HiddenInput)
    date = forms.CharField(required=False)#forms.DateField(widget=SelectDateWidget(), initial=datetime.date.today())    
    results = forms.CharField(widget=forms.Textarea, required=False)
    tags = TagField(widget=TagAutocomplete(), required=False)
    
    def clean_results(self):
        print self.cleaned_data
        has_result = self.cleaned_data.get('has_result', False)
        result = self.cleaned_data['results']
        print has_result
        print result
        print result == ''
        if has_result == True and result == '':
            raise forms.ValidationError(result_required)
      
        return result
        

class ResultForm(forms.Form):
    date = forms.CharField(required=False)#forms.DateField(widget=SelectDateWidget(), initial=datetime.date.today())    
    results = forms.CharField(widget=forms.Textarea, required=False)
    tags = TagField(widget=TagAutocomplete(), required=False)    