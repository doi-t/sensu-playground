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
