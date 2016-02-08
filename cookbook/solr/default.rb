package 'java-1.8.0'

execute "download solr-#{node['solr']['version']}" do
  command "curl -o solr-#{node['solr']['version']}.tgz http://www.us.apache.org/dist/lucene/solr/#{node['solr']['version']}/solr-#{node['solr']['version']}.tgz"
  not_if 'test -d /opt/solr'
  cwd '/tmp'
end

execute 'extract install script' do
  command "tar zxf solr-#{node['solr']['version']}.tgz solr-#{node['solr']['version']}/bin/install_solr_service.sh"
  not_if 'test -d /opt/solr'
  cwd '/tmp'
end

execute "install solr-#{node['solr']['version']}" do
  command "solr-#{node['solr']['version']}/bin/install_solr_service.sh solr-#{node['solr']['version']}.tgz && rm solr-#{node['solr']['version']}.tgz"
  not_if 'test -d /opt/solr'
  cwd '/tmp'
end

service 'solr' do
  action [:start, :enable]
end

execute "create core" do
  command "/opt/solr/bin/solr create -c #{node['solr']['core']} -d basic_configs"
  not_if "test -d /var/solr/data/#{node['solr']['core']}"
  user 'solr'
end

remote_file 'copy solr schema.xml' do
  source 'files/schema.xml'
  path "/var/solr/data/#{node['solr']['core']}/conf/schema.xml"
end

remote_file 'copy solr solrconfig.xml' do
  source 'files/solrconfig.xml'
  path "/var/solr/data/#{node['solr']['core']}/conf/solrconfig.xml"
end
