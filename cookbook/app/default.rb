%w(libxml2-devel libxslt-devel sqlite-devel gcc-c++).each do |name|
  package name
end

execute 'add nodejs repo' do
  command 'curl --silent --location https://rpm.nodesource.com/setup | bash -'
  not_if 'test -f /usr/bin/node'
end

package 'nodejs'

execute 'install bower' do
  command 'npm install -g bower'
  not_if 'npm list -g | grep bower'
end

user 'create rails user' do
  username 'rails'
  password 'password'
end

directory 'create app directory' do
  path "/var/www/#{node['app']['name']}"
  owner 'rails'
  group 'rails'
end

directory 'create app shared directory' do
  path "/var/www/#{node['app']['name']}/shared"
  owner 'rails'
  group 'rails'
end

remote_directory 'copy app shared config directory' do
  source 'shared_files'
  path "/var/www/#{node['app']['name']}/shared/config"
  owner 'rails'
  group 'rails'
end

directory 'create app shared tmp directory' do
  path "/var/www/#{node['app']['name']}/shared/tmp"
  owner 'rails'
  group 'rails'
end
