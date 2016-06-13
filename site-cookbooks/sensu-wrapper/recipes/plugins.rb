sensu_gem 'sensu-plugin'
sensu_gem 'sensu-plugins-process-checks'
sensu_gem 'sensu-plugins-cpu-checks'
sensu_gem 'sensu-plugins-network-checks'
sensu_gem 'sensu-plugins-disk-checks'
sensu_gem 'sensu-plugins-load-checks'
sensu_gem 'sensu-plugins-ntp'
sensu_gem 'sensu-plugins-memory-checks' do
  action :install
  version '0.0.5'
end

# for check-ports.rb
package 'nmap' do
  action :install
end

# for check-memory-percent.rb
package 'bc' do
  action :install
end
