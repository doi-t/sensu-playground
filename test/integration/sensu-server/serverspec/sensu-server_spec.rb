require 'serverspec'

set :backend, :exec

packages = %w{
sensu
uchiwa
}

packages.each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

describe file('/usr/local/bin/redis-server') do
  it { should be_file  }
  it { should be_executable  }
end

describe service('redis-server') do
  it { should be_running }
end

describe file('/usr/local/bin/redis-cli') do
  it { should be_file  }
  it { should be_executable  }
end

describe service('rabbitmq-server') do
  it { should be_enabled }
  it { should be_running }
end

describe service('sensu-server') do
  it { should be_enabled }
  it { should be_running }
end

# sensu-api
describe port(4567) do
  it { should be_listening }
end

# rabbitmq
describe port(5672) do
  it { should be_listening }
end

# redis
describe port(6379) do
  it { should be_listening }
end

# uchiwa
describe port(3000) do
  it { should be_listening }
end

# config directories

config_directories = %w{
/opt/sensu
/opt/uchiwa
/etc/sensu/conf.d/checks
/etc/sensu/conf.d/handlers
}

config_directories.each do |config_directory|
  describe file(config_directory) do
    it { should be_directory }
    it { should exist }
  end
end

# config files
describe file('/etc/default/sensu') do
  it { should be_file  }
  it { should exist }
  its(:content) { should match /EMBEDDED_RUBY=true/ }
end

config_files = %w{
/etc/rabbitmq/enabled_plugins
/etc/rabbitmq/rabbitmq.config
/etc/rabbitmq/rabbitmq-env.conf
/etc/sensu/config.json
/etc/sensu/uchiwa.json
/etc/default/uchiwa
/etc/sensu/conf.d/client.json
/etc/sensu/conf.d/slack.json
/var/log/sensu/sensu-server.log
/var/log/sensu/sensu-api.log
}

config_files.each do |config_file|
  describe file(config_file) do
    it { should be_file  }
    it { should exist }
  end
end
