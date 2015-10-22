if node['mysql'] && node['mysql']['install']
  execute 'add mysql repo' do
    command 'rpm -ivh http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm '
    not_if 'test -f /etc/yum.repos.d/mysql-community.repo'
  end

  package 'mysql-community-client'
  package 'mysql-community-server'
  package 'mysql-community-devel'

  template '/etc/my.cnf' do
    source 'templates/my.cnf'
    owner 'root'
    group 'root'
    mode '0644'
  end

  service 'mysqld' do
    action [:enable, :start]
  end

  execute 'create application database' do
    command "mysql -u root -e 'CREATE DATABASE IF NOT EXISTS #{node['mysql']['database']};'"
    not_if "mysql -u root -Ne 'SHOW DATABASES;' | grep #{node['mysql']['database']}"
  end

  execute 'create database user' do
    command "mysql -u root -e 'CREATE USER #{node['mysql']['username']}@#{node['mysql']['host']} IDENTIFIED BY \"#{node['mysql']['password']}\";'"
    not_if "mysql -u root -Ne 'SELECT user FROM mysql.user;' | grep #{node['mysql']['username']}"
  end

  execute 'grant database access to user' do
    command "mysql -u root -e 'GRANT ALL PRIVILEGES ON #{node['mysql']['database']}.* TO #{node['mysql']['username']}@\"%\";'"
    not_if "mysql -u root -Ne 'SHOW GRANTS FOR #{node['mysql']['username']}@\"%\";' | grep #{node['mysql']['database']}"
  end
end
