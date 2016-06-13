install_packages = %w{
tree
}

install_packages.each do |pkg|
  package "#{pkg}" do
    action :install
  end
end
