app_path = '/var/www/rg-portal'
app_shared_path = "#{app_path}/shared"

listen "#{app_shared_path}/tmp/unicorn.sock"
pid "#{app_shared_path}/tmp/unicorn.pid"

worker_processes 4
preload_app true

working_directory "#{app_path}/current/"

stdout_path "#{app_shared_path}/tmp/unicorn.stdout.log"
stderr_path "#{app_shared_path}/tmp/unicorn.stderr.log"

before_exec do |server|
  ENV['BUNDLE_GEMFILE'] = "#{app_path}/current/Gemfile"
end

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!

  old_pid = "#{ server.config[:pid] }.oldbin"
  unless old_pid == server.pid
    begin
      Process.kill :QUIT, File.read(old_pid).to_i
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
