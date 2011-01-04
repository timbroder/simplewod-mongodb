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
    time = forms.CharField(required=False)
    weight = forms.IntegerField(required=False)
    tags = TagField(widget=TagAutocomplete(), required=False) 
    notes = forms.CharField(widget=forms.Textarea, required=False)
    
class ResultFormAdd(ResultForm):
    date = forms.CharField()
    #results = forms.CharField(widget=forms.Textarea)
    
    def clean(self):
        result = self.cleaned_data['results']
        time = self.cleaned_data['time']
        weight = None
        try:
            weight = self.cleaned_data['weight']
        except KeyError:
            msg = u"Please enter a number"
            self._errors["weight"] = self.error_class([msg])
            #del self.cleaned_data["weight"]

        if debug:
            print "clean ResultFormAdd"
            print result
            print time
            print weight

        if result == '' and time == '' and (weight == '' or weight == None):
            print "YAY?"
            msg = u"You must enter a result, or a weight, or a time."
            self._errors["results"] = self.error_class([msg])
            del self.cleaned_data["results"]


            raise forms.ValidationError(result_required)
        print 'VALID'
        return self.cleaned_data
    
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
        time = self.cleaned_data['time']
        
        try:
            weight = self.cleaned_data['weight']
        except KeyError:
            msg = u"Please enter a number"
            self._errors["weight"] = self.error_class([msg])
            #del self.cleaned_data["weight"]

        if has_result == True and (result == '' and time == '' and (weight == '' or weight == None)):
            print "YAY?"
            msg = u"You must enter a result, or a weight, or a time."
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