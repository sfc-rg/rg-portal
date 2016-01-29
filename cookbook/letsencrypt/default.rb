return unless node['letsencrypt']

git 'clone letsencrypt repository' do
  destination '/opt/letsencrypt'
  repository 'git://github.com/letsencrypt/letsencrypt.git'
end

package 'centos-release-SCL'
package 'python27 python27-python-tools python27-devel python27-pip python27-setuptools python27-virtualenv dialog'

execute 'initialize letsencrypt certificate' do
  command "scl enable python27 \"/opt/letsencrypt/letsencrypt-auto certonly --webroot -w #{node['letsencrypt']['document_root']} -d #{node['letsencrypt']['domain']} -m #{node['letsencrypt']['email']} --agree-tos\""
  not_if 'test -d /etc/letsencrypt'
end

file 'regist letsencrypt auto renew script in cron.d' do
  path '/etc/cron.d/letsencrypt'
  content "0 5 1 * * root scl enable python27 \"/opt/letsencrypt/letsencrypt-auto certonly --webroot -w #{node['letsencrypt']['document_root']} -d #{node['letsencrypt']['domain']} -m #{node['letsencrypt']['email']} --agree-tos --renew-by-default\""
  owner 'root'
  group 'root'
  mode '0644'
end
