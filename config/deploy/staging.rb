set :branch, ENV.fetch('BRANCH', nil) || ENV.fetch('WERCKER_GIT_BRANCH', nil) || 'master'
set :deploy_to, '/var/www/team-io'

set :unicorn_pid, "#{shared_path}/tmp/unicorn.pid"
set :unicorn_config_path, "#{current_path}/config/unicorn/staging.rb"

server '203.178.128.99', user: 'admin', roles: %w{web app db}
