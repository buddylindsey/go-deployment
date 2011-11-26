# Welcome to go-deployment v 0.01

### Introduction
Go deployment was built out of a want and a need. A want to deploy similar to how heroku deployments are handled, and a need to do it on my own server, specifically for godjango.com. I develop both Rails and Django applications so I wanted a script that handled both.

### What go-deployment current does
At this point and time you can only deploy django applications, but that should change within the next week or so, unless someone else wants to add the ability sooner. It does not handle database stuff automatically, but is almost there and requires you to login and do a syncdb and migrations.

### Notes: (please read)
This was a project I started and knocked out in about 7 hours so it is very, very, very rough right now and unless you use it just right, which isn't hard, it can break.

# Getting Started
## Installation

1) Setup a user on your server to run everything through

2) Install the following:
* ruby
* python
* pip
* virtualenv
* apache2
* mod_wsgi

3) Get your code and I recommend putting in the home folder of the user you are doing this all with.

4) Make the following folders

> settings

> virtulenvs

> sites

> repos

5) add your public ssh-key to .ssh/authorized_keys like follows

> command="/home/user/deploy.rb" ssh-rsa .....

> make sure you put the correct path to the deploy.rb file

6) edit deploy.rb, add_deploy.rb, templates/django.wsgi, and templates/virtualhost with all the correct paths.

## Usage

1) use add_deploy.rb to add your website.

> ruby add_deploy.rb

2) use the url of your website things won't work correctly if you don't

3) take the template of the virtualhost and copy it into /etc/apache2/sites-available

4) rename the file to what you want for your site I usually use the url for the filename

5) replace SITEURL in the file with your sites url that you used for add_deploy.rb (this will be automated in the future)

6) run: sudo a2ensite site.com

7) add a remote to your current git project. Much like heroku make sure your django project is in a subfolder.

> git remote add go user@site.com:repos/site.com.git

>> file structure should be something like

>> project_name/

>> project_name/requirements.txt

>> project_name/project_name/

>> project_name/project_name/__init__.py

8) make sure you have a requirements.txt with django in it. (it must be in the root folder)

9) do a: git push go master

10) check your site.

## Assumptions

The above guid assumes you set the proper permissions to everything and your url is pointing at your server

# Contributions

Contributions are gladley accepted and welcomed from all those who wish to help out.

# Changelog

v 0.01 - Basic scripts are working for Django Deployments

# License

Copyright (c) 2011 Buddy Lindsey, Jr. 

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
