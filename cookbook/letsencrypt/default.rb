return unless node['letsencrypt']

package 'git'

git 'clone letsencrypt repository' do
  destination '/opt/letsencrypt'
  repository 'git://github.com/letsencrypt/letsencrypt.git'
end

directory '/var/letsencrypt' do
  action :create
  not_if "test -d /etc/letsencrypt/live/#{node['letsencrypt']['domain']}"
end

execute 'initialize letsencrypt certificate' do
  command "/opt/letsencrypt/letsencrypt-auto certonly --webroot -w /var/letsencrypt -d #{node['letsencrypt']['domain']} -m #{node['letsencrypt']['email']} --agree-tos && /bin/rm -rf /var/letsencrypt/.well-known"
  not_if "test -d /etc/letsencrypt/live/#{node['letsencrypt']['domain']}"
end

directory '/var/letsencrypt' do
  action :delete
  not_if "test -d /etc/letsencrypt/live/#{node['letsencrypt']['domain']}"
end

file 'regist letsencrypt auto renew script in cron.d' do
  path '/etc/cron.d/letsencrypt'
  content "0 5 1 * * root /opt/letsencrypt/letsencrypt-auto certonly --webroot -w #{node['letsencrypt']['document_root']} -d #{node['letsencrypt']['domain']} -m #{node['letsencrypt']['email']} --agree-tos --renew-by-default && /sbin/service nginx reload && /bin/rm -rf #{node['letsencrypt']['document_root']}/.well-known"
  owner 'root'
  group 'root'
  mode '0644'
end
