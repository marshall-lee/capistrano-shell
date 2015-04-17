desc 'Opens SSH shell on remote host in current release directory'
task :shell do
  hosts = []
  on roles(:all), in: :sequence, wait: 0 do |host|
    hosts << host
  end

  if hosts.none?
    puts 'No servers matched'
    exit
  elsif hosts.length == 1
    set :shell_server_number, 1
  else
    hosts.each_with_index do |host, i|
      puts "#{i + 1}) #{host} (#{host.roles.to_a.join ' '})"
    end
  end

  i = fetch(:shell_server_number).to_i - 1
  host = hosts[i]
  options = host.netssh_options

  cmd = ['ssh', '-t']
  cmd << '-A' if options[:forward_agent]
  Array(options[:keys]).each do |key|
    cmd << '-i'
    cmd << key
  end
  if options[:port]
    cmd << '-p'
    cmd << options[:port]
  end
  user_hostname = [options[:user], host.hostname].compact.join('@')
  cmd << user_hostname

  shell_cmd = fetch :shell_cmd

  if host.properties.fetch(:no_release)
    cmd << shell_cmd
  else
    cmd << "cd #{release_path} && #{shell_cmd}"
  end

  puts "Executing #{cmd.join ' '}"
  exec(*cmd)
end

namespace :load do
  task :defaults do
    set :shell_server_number, ask('server number', 1)
    set :shell_cmd, '$SHELL --login'
  end
end
