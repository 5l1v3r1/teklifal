# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :user, 'deploy'
set :application, "biteklif"
set :rails_env, 'production'
set :branch, "deploy"
set :repo_url, "git@github.com:cihad/biteklif.git"
set :deploy_to, "/home/deploy/apps/biteklif"
set :pty, true

append :linked_files, "config/master.key", "config/puma.rb"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", 'public/uploads'

set :config_example_suffix, '.example'
set :config_files, %w{config/master.key}
set :puma_conf, "#{shared_path}/config/puma.rb"
set :migration_role, :app
set :assets_manifests, ['app/assets/config/manifest.js']
set :chruby_ruby, "ruby-2.5.1"
set :nginx_domains, "46.101.223.225"
set :app_server_socket, "#{shared_path}/tmp/sockets/#{fetch :application}.sock"


namespace :deploy do
  before 'check:linked_files', 'config:push'
  before 'check:linked_files', 'puma:config'
  before 'check:linked_files', 'puma:nginx_config'
  before 'deploy:migrate', 'deploy:db:create'
  after 'puma:smart_restart', 'nginx:restart'
end