require_relative 'config/application'
require 'capistrano/setup'
require "capistrano/scm/git"
require 'capistrano/deploy'
require 'capistrano/nginx'
require 'capistrano/puma'
require 'capistrano/puma/nginx'
require "capistrano/chruby"
require 'capistrano/rails'
require 'capistrano/rails/db'
require 'sshkit/sudo'

install_plugin Capistrano::SCM::Git
install_plugin Capistrano::Puma  # Default puma tasks
install_plugin Capistrano::Puma::Nginx  # if you want to upload a nginx site template
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }