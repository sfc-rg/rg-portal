package 'epel-release'

package 'install munin' do
  name 'munin'
  version '2.0.29-1.el7'
end

package 'install munin-node' do
  name 'munin-node'
  version '2.0.29-1.el7'
end

# nginx
link 'link munin plugin - nginx_request' do
  link '/etc/munin/plugins/nginx_request'
  to '/usr/share/munin/plugins/nginx_request'
end

link 'link munin plugin - nginx_status' do
  link '/etc/munin/plugins/nginx_status'
  to '/usr/share/munin/plugins/nginx_status'
end

remote_file 'copy munin plugin - nginx_status_codes' do
  source 'files/nginx_status_codes'
  path '/usr/share/munin/plugins/nginx_status_codes'
  owner 'root'
  group 'root'
  mode '0755'
end

link 'link munin plugin - nginx_status_codes' do
  link '/etc/munin/plugins/nginx_status_codes'
  to '/usr/share/munin/plugins/nginx_status_codes'
end

# unicorn
remote_file 'copy munin plugin - unicorn_' do
  source 'files/unicorn_'
  path '/usr/share/munin/plugins/unicorn_'
  owner 'root'
  group 'root'
  mode '0755'
end

link 'link munin plugin - unicorn_average' do
  link '/etc/munin/plugins/unicorn_average'
  to '/usr/share/munin/plugins/unicorn_'
end

link 'link munin plugin - unicorn_memory' do
  link '/etc/munin/plugins/unicorn_memory'
  to '/usr/share/munin/plugins/unicorn_'
end

link 'link munin plugin - unicorn_processes' do
  link '/etc/munin/plugins/unicorn_processes'
  to '/usr/share/munin/plugins/unicorn_'
end

remote_file 'copy munin plugin - unicorn_status' do
  source 'files/unicorn_status'
  path '/usr/share/munin/plugins/unicorn_status'
  owner 'root'
  group 'root'
  mode '0755'
end

link 'link munin plugin - unicorn_status' do
  link '/etc/munin/plugins/unicorn_status'
  to '/usr/share/munin/plugins/unicorn_status'
end

remote_file 'copy munin plugin - unicorn_memory_status' do
  source 'files/unicorn_memory_status'
  path '/usr/share/munin/plugins/unicorn_memory_status'
  owner 'root'
  group 'root'
  mode '0755'
end

link 'link munin plugin - unicorn_memory_status' do
  link '/etc/munin/plugins/unicorn_memory_status'
  to '/usr/share/munin/plugins/unicorn_memory_status'
end

template '/etc/munin/plugin-conf.d/unicorn_' do
  source 'templates/unicorn_.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

service 'munin-node' do
  action [:enable, :start]
end
