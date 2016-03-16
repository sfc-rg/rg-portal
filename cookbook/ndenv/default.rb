# https://blog.kazu69.net/2015/06/13/make-nodejs-development-environment-vagrant-and-docker-with-itamae/

package 'openssl-devel'
package 'git'
package 'tar'

NDENV_DIR = '/usr/local/ndenv'
NDENV_SCRIPT = '/etc/profile.d/ndenv.sh'

# Download
git NDENV_DIR do
  repository "git://github.com/riywo/ndenv.git"
end

directory "#{NDENV_DIR}/plugins" do
  not_if "test -d #{NDENV_DIR}/plugins"
end

git "#{NDENV_DIR}/plugins/node-build" do
  repository "git://github.com/riywo/node-build.git"
end

# Setup profile script
file NDENV_SCRIPT do
  content <<-EOH
export NDENV_ROOT=#{NDENV_DIR}
export PATH="${NDENV_ROOT}/bin:${PATH}"
eval "$(ndenv init -)"
EOH
  owner 'root'
  group 'root'
  mode '0644'
end

# Install nodejs and packages
node['ndenv']['versions'].each do |version|
  execute "install node #{version}" do
    command <<-EOH
      source #{NDENV_SCRIPT}
      ndenv install -s #{version}
      ndenv rehash
    EOH
    not_if "source #{NDENV_SCRIPT}; ndenv versions | grep #{version}"
  end
end

execute "set global node #{node['ndenv']['global']}" do
  command <<-EOH
    source #{NDENV_SCRIPT}
    ndenv global #{node['ndenv']['global']}
    ndenv rehash
  EOH
  not_if "source #{NDENV_SCRIPT}; ndenv global | grep #{node['ndenv']['global']}"
end

node['ndenv']['packages'].each do |pkg|
  execute "npm install #{pkg}" do
    command "source #{NDENV_SCRIPT}; npm install -g #{pkg}"
    not_if "source #{NDENV_SCRIPT}; npm list -g | grep #{pkg}"
  end
end
