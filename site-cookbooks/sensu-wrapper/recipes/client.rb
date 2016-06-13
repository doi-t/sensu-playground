include_recipe "sensu::default"

sensu_client node.name do
  address node.ipaddress
  subscriptions node.roles + ["all"]
end
