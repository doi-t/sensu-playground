sensu_handler "default" do
  type "pipe"
  command "cat"
end

# slack

sensu_gem 'sensu-plugins-slack'

sensu_handler "slack" do
  type "pipe"
  command "handler-slack.rb"
  severities [ "ok", "critical","warning" ]
end

sensu_snippet 'slack' do
  content(
    webhook_url: node['slack']['webhook_url'],
    channel: node['slack']['channel'],
    message_prefix: node['slack']['message_prefix'],
    surround: node['slack']['surround'],
    bot_name: node['slack']['bot_name']
  )
end
