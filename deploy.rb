#!/usr/bin/ruby
require 'date'

def tell(message)
  $stderr.puts message
end

#setup data
DATETIME = DateTime.now.strftime("%Y%m%d%H%M%S")
ROOT_DIR = "/home/ubuntu"
REPO_DIR = "#{ROOT_DIR}/repos"
SITE_DIR = "#{ROOT_DIR}/sites"
SETTINGS_DIR = "#{ROOT_DIR}/settings"
VIRTUALENVS_DIR = "#{ROOT_DIR}/virtualenvs"

def python_app
  $stderr.puts "Do you want to run syncdb? y/n"
  answer = $stdin.gets

  if(answer.chomp == "y")
    $stderr.puts "-- Running syncdb"
    #run syncdb command
  end

  $stderr.puts "Do you want to run south migrations? y/n"
  answer = $stdin.gets

  if(answer.chomp == "y")
    $stderr.puts "-- Running migrations"
    #run migrations
  end
end

def site_url
  ENV['SSH_ORIGINAL_COMMAND'].split(' ')[1].gsub("'", "").split("/")[1][0..-5]
end

def detect_app
  if(File.exists?("#{SITE_DIR}/#{site_url}/#{DATETIME}/requirements.txt"))
    return "django"
  end
end

def proj_name
  Dir["#{SITE_DIR}/#{site_url}/active/*"].each do |d|
    if(File::directory?(d))
      return d.to_s.split('/').last
    end
  end
end

############
# Main Execution of Deploy Script
############
# do commit
fork do 
  system(ENV['SSH_ORIGINAL_COMMAND'])
end
Process.wait

tell "-- Recieved Push"
fork do
  `git clone #{REPO_DIR}/#{site_url}.git #{SITE_DIR}/#{site_url}/#{DATETIME}`
end
Process.wait

if(detect_app == "django")
  tell "-- Django App Detected"
else
  tell "-- Sorry no Django App Detected"
  exit()
end

$stderr.puts "-- Setting up a virtualenv"
`virtualenv --no-site-packages #{VIRTUALENVS_DIR}/#{site_url}`

tell "-- Installing dependencies"
`pip install -E #{VIRTUALENVS_DIR}/#{site_url} -r #{SITE_DIR}/#{site_url}/#{DATETIME}/requirements.txt`

tell "-- Doing web configuration stuff"
# add, modify or something else of virtualconf files
# take url of git repo name modify virtualconf

if(File.exists?("#{SITE_DIR}/#{site_url}/active"))
  `rm -rf #{SITE_DIR}/#{site_url}/active`
end
`ln -s #{SITE_DIR}/#{site_url}/#{DATETIME}/ #{SITE_DIR}/#{site_url}/active`
`sed 's/SITENAME/#{site_url}/g' /#{ROOT_DIR}/templates/django.wsgi > #{SITE_DIR}/#{site_url}/active/django.wsgi`

$stderr.puts "-- Adding server specific settings if there are any"
# take settings place somewhere and copy over
if(File.exists?("#{SETTINGS_DIR}/#{site_url}/settings_local.py"))
  `cp #{SETTINGS_DIR}/#{site_url}/settings_local.py #{SITE_DIR}/#{site_url}/#{DATETIME}`
  # append settings import to settings file
end

# symlink DATETIME to active folder
tell "-- App deployed"

# does a hard exit
exit()
