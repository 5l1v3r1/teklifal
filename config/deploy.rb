# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :user, 'deployer'
set :application, "biteklif"
set :branch, "develop"
set :repo_url, "git@github.com:cihad/biteklif.git"
set :deploy_to, "/home/deployer/apps/biteklif"
set :pty, true

# https://github.com/capistrano/rails#usage
set :rails_env, 'production'
set :migration_role, :app
set :assets_manifests, ['app/assets/config/manifest.js']
set :keep_assets, 2
append :linked_files, "config/master.key", "config/puma.rb"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", 'public/uploads'

# https://github.com/capistrano/chruby#usage
set :chruby_ruby, "ruby-2.5.1"

# https://github.com/seuros/capistrano-puma
set :puma_conf, "#{shared_path}/config/puma.rb"

# https://github.com/platanus/capistrano3-nginx#usage
set :nginx_domains, "46.101.223.225"
set :app_server_socket, "#{shared_path}/tmp/sockets/#{fetch :application}.sock"

namespace :deploy do
  before 'check:linked_files', 'puma:config'
  before 'check:linked_files', 'puma:nginx_config'
  before 'deploy:migrate', 'deploy:db:create'
  after 'puma:smart_restart', 'nginx:restart'
end