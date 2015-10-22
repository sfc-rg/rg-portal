directory 'create .ssh directory' do
  path "/home/rails/.ssh"
  owner 'rails'
  group 'rails'
  mode '0700'
end

execute 'create ssh key' do
  command 'ssh-keygen -f .ssh/id_rsa -t rsa -N ""'
  not_if 'test -f /home/rails/.ssh/id_rsa'
  user 'rails'
end

local_ruby_block 'show id_rsa.pub' do
  block do
    puts '==== BEGIN SSH PUBLIC KEY ===='
    puts run_command('cat /home/rails/.ssh/id_rsa.pub').stdout
    puts '====  END SSH PUBLIC KEY  ===='
  end
end

remote_file 'copy authorized_keys' do
  source 'files/authorized_keys'
  path "/home/rails/.ssh/authorized_keys"
  owner 'rails'
  group 'rails'
  mode '0600'
end
