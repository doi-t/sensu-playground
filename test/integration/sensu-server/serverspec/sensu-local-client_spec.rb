require 'serverspec'

set :backend, :exec

packages = %w{
sensu
}

packages.each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

describe service('ntpd') do
  it { should be_enabled }
  it { should be_running }
end

describe service('sensu-client') do
  it { should be_enabled }
  it { should be_running }
end

config_files = %w{
/etc/sensu/config.json
/etc/sensu/conf.d/client.json
}

config_files.each do |config_file|
  describe file(config_file) do
    it { should be_file  }
    it { should exist }
  end
end
