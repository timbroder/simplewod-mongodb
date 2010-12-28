from django import forms
from django.forms.extras.widgets import SelectDateWidget
import datetime
from tagging.forms import TagField
from tagging_autocomplete.widgets import TagAutocomplete
import settings 

result_required = "If you are adding a result, this field is required"
debug = getattr(settings, 'DEBUG', None)

class ResultForm(forms.Form):
    date = forms.CharField(required=False)#forms.DateField(widget=SelectDateWidget(), initial=datetime.date.today())    
    results = forms.CharField(widget=forms.Textarea, required=False)
    tags = TagField(widget=TagAutocomplete(), required=False) 
    
class ResultFormAdd(ResultForm):
    date = forms.CharField()
    results = forms.CharField(widget=forms.Textarea)
    
class ResultFormAjax(ResultForm):
    wod_id = forms.CharField(required = True)
    submitted = forms.BooleanField(initial=False, widget=forms.HiddenInput)

class WodForm(ResultForm):
    name = forms.CharField(required=False)
    workout = forms.CharField(widget=forms.Textarea, required=True)
    has_result = forms.BooleanField(initial=True, widget=forms.HiddenInput, required=False)
    wod_tags = TagField(widget=TagAutocomplete(), required=True)
    
    def clean(self):
        if debug:
            print '- add clean result form'
        print self
        print self.cleaned_data
        has_result = self.cleaned_data.get('has_result', False)
        result = self.cleaned_data['results']
        print has_result
        print result
        print result == ''
        if has_result == True and result == '':
            print "YAY?"
            msg = u"This field is required."
            self._errors["results"] = self.error_class([msg])
            del self.cleaned_data["results"]


            raise forms.ValidationError(result_required)
        print 'VALID'
        return self.cleaned_data
        
class SettingsForm(forms.Form):
    email = forms.EmailField()
    private_wods = forms.BooleanField(required=False)
    

# A simple contact form with four fields.
class ContactForm(forms.Form):
    name = forms.CharField()
    email = forms.EmailField()
    topic = forms.CharField()
    message = forms.CharField(widget=forms.Textarea)