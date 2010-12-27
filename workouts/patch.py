#change default registartion form
from registration.backends.default import DefaultBackend
from registration.forms import RegistrationFormUniqueEmail

def get_form_class(self, request):
    """
    Return the default form class used for user registration.
    
    """
    return RegistrationFormUniqueEmail

DefaultBackend.get_form_class = get_form_class