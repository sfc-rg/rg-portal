execute 'add nginx repo' do
  command 'rpm -ivh http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm'
  not_if 'test -f /etc/yum.repos.d/nginx.repo'
end

package 'install nginx' do
  name 'nginx'
  version '1.8.0-1.el6.ngx'
end

template '/etc/nginx/nginx.conf' do
  source 'templates/nginx.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

service 'nginx' do
  action [:enable, :start]
end
