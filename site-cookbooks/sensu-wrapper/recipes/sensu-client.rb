include_recipe 'sensu::default'
include_recipe 'sensu-wrapper::client'
include_recipe 'sensu-wrapper::plugins'
include_recipe 'sensu::client_service'
include_recipe 'ntp'
