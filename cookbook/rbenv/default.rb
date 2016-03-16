# http://qiita.com/fukuiretu/items/337e6ae15c1f01e93ec3

package 'epel-release'
package 'gcc'
package 'openssl-devel'
package 'libyaml-devel'
package 'readline-devel'
package 'zlib-devel'
package 'libffi-devel'
package 'git'

RBENV_DIR = '/usr/local/rbenv'.freeze
RBENV_SCRIPT = '/etc/profile.d/rbenv.sh'.freeze

# Download
git RBENV_DIR do
  repository 'git://github.com/sstephenson/rbenv.git'
end

directory "#{RBENV_DIR}/plugins" do
  not_if "test -d #{RBENV_DIR}/plugins"
end

git "#{RBENV_DIR}/plugins/ruby-build" do
  repository 'git://github.com/sstephenson/ruby-build.git'
end

# Setup profile script
file RBENV_SCRIPT do
  content <<-EOH
export RBENV_ROOT="#{RBENV_DIR}"
export PATH="${RBENV_ROOT}/bin:${PATH}"
eval "$(rbenv init --no-rehash -)"
EOH
  owner 'root'
  group 'root'
  mode '0644'
end

# Install ruby and gems
node['rbenv']['versions'].each do |version|
  execute "install ruby #{version}" do
    command "source #{RBENV_SCRIPT}; rbenv install #{version}"
    not_if "source #{RBENV_SCRIPT}; rbenv versions | grep #{version}"
  end
end

execute "set global ruby #{node['rbenv']['global']}" do
  command "source #{RBENV_SCRIPT}; rbenv global #{node['rbenv']['global']}; rbenv rehash"
  not_if "source #{RBENV_SCRIPT}; rbenv global | grep #{node['rbenv']['global']}"
end

node['rbenv']['gems'].each do |gem|
  execute "gem install #{gem}" do
    command "source #{RBENV_SCRIPT}; gem install #{gem}; rbenv rehash"
    not_if "source #{RBENV_SCRIPT}; gem list | grep #{gem}"
  end
end
