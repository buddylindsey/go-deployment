import os
import sys

sys.stdout = sys.stderr
sys.path.append('/home/ubuntu/sites/SITENAME/active')

import site
site.addsitedir('/home/ubuntu/virtualenvs/SITENAME/lib/python2.7/site-packages')

import os
os.environ['PYTHON_EGG_CACHE'] = '/home/ubuntu/sites/SITENAME/active/.egg-cache'
os.environ['DJANGO_SETTINGS_MODULE'] = 'settings'

activate_this = os.path.join("/home/ubuntu/virtualenvs/SITENAME", "bin/activate_this.py")
execfile(activate_this, dict(__file__=activate_this))

import django.core.handlers.wsgi
application = django.core.handlers.wsgi.WSGIHandler()
