package 'epel-release'

execute 'add nginx repo' do
  command 'rpm -ivh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm'
  not_if 'test -f /etc/yum.repos.d/nginx.repo'
end

package 'install nginx' do
  name 'nginx'
  version '1.10.2-1.el7.ngx'
end

template '/etc/nginx/nginx.conf' do
  source 'templates/nginx.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

remote_file '/etc/logrotate.d/nginx' do
  source 'files/nginx'
  owner 'root'
  group 'root'
  mode '0644'
end

service 'nginx' do
  action [:enable, :start]
end
