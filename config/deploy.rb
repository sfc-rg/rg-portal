lock '3.4.0'

set :application, 'rg-portal'
set :repo_url, 'git@github.com:sfc-arch/rg-team-io.git'
set :scm, :git

set :rvm_type, :system
set :rvm_ruby_version, '2.2.1'

set :format, :pretty
set :log_level, :debug
set :rails_env, :production
set :keep_releases, 5

set :linked_files, %w{config/secrets.yml config/oauth.yml}

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end
