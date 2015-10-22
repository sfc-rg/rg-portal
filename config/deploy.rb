lock '3.4.0'

set :application, 'rg-portal'
set :repo_url, 'git@github.com:sfc-arch/rg-team-io.git'
set :scm, :git

set :rbenv_type, :system
set :rbenv_ruby, '2.2.1'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all

set :format, :pretty
set :log_level, :debug
set :rails_env, :production
set :keep_releases, 5

set :linked_files, %w{config/ldap.yml config/secrets.yml config/oauth.yml config/database.yml}

set :bundle_env_variables, { nokogiri_use_system_libraries: 1 }

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end

before 'deploy:compile_assets', 'bower:install'
namespace :bower do
  task :install do
    on roles(:web) do
      within release_path do
        execute :rake, 'bower:install CI=true'
      end
    end
  end
end

before 'deploy:compile_assets', 'gemoji:install'
namespace :gemoji do
  task :install do
    on roles(:web) do
      within release_path do
        execute :rake, 'emoji'
      end
    end
  end
end
