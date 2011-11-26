ROOT_DIR = "/home/ubuntu"

# initialize data store
# add user
# add authkey for user

puts "What is the URL of the new site?"
url = gets

# settings
`mkdir -p #{ROOT_DIR}/settings/#{url.chomp}/`
# site specific
`mkdir -p #{ROOT_DIR}/sites/#{url.chomp}/`
# get repo stuff
`mkdir #{ROOT_DIR}/repos/#{url.chomp}.git`
Dir.chdir("#{ROOT_DIR}/repos/#{url.chomp}.git")
`git init --bare`
