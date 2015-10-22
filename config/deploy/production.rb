set :branch, ENV.fetch('BRANCH', nil) || ENV.fetch('WERCKER_GIT_BRANCH', nil) || 'master'
set :deploy_to, '/var/www/rg-portal'

set :unicorn_pid, "#{shared_path}/tmp/unicorn.pid"
set :unicorn_config_path, "#{current_path}/config/unicorn/production.rb"

server '160.16.64.33', port: 22, user: 'rails', roles: %w{web app db}
