sensu_server_processes = {
'sensu-api' => 1,
'sensu-server' => 1,
'uchiwa' => 2,
'redis-server' => 1,
'rabbitmq-server' => 2,
}

sensu_server_processes.each do |name, number_of_process|
  sensu_check "check-process-#{name}" do
    print name
    command "/opt/sensu/embedded/bin/check-process.rb -p #{name} --critical-under #{number_of_process}"
    handlers ["default", "slack"]
    subscribers ["sensu-server"]
    interval 30
    standalone false
    additional(
      :notification => "#{name} is not running.",
      :occurrences => 5,
      :refresh => 180
    )
  end
end

processes = {
'crond' => 1,
'ntpd' => 1,
}

processes.each do |name, number_of_process|
  sensu_check "check-process-#{name}" do
    print name
    command "/opt/sensu/embedded/bin/check-process.rb -p #{name} --critical-under #{number_of_process}"
    handlers ["default", "slack"]
    subscribers ["sensu-server", "sensu-client"]
    interval 30
    standalone false
    additional(
      :notification => "#{name} is not running.",
      :occurrences => 5,
      :refresh => 180
    )
  end
end

sensu_check "check-cpu" do
  command "/opt/sensu/embedded/bin/check-cpu.rb -w 80 -c 100"
  handlers ["default", "slack"]
  subscribers ["sensu-server", "sensu-client"]
  interval 30
  standalone false
  additional(
    :occurrences => 5,
    :refresh => 180
  )
end

sensu_check "check-load-nagios" do
  command "/usr/lib64/nagios/plugins/check_load -c 1,2,3"
  handlers ["default", "slack"]
  subscribers ["sensu-server", "sensu-client"]
  interval 30
  standalone false
  additional(
    :occurrences => 5,
    :refresh => 180
  )
end

sensu_check "check-memory-percent" do
  command "/opt/sensu/embedded/bin/check-memory-percent.rb -w 50 -c 80"
  handlers ["default", "slack"]
  subscribers ["sensu-server", "sensu-client"]
  interval 30
  standalone false
  additional(
    :occurrences => 5,
    :refresh => 180
  )
end

sensu_check "check-ntp" do
  command "/opt/sensu/embedded/bin/check-ntp.rb -w 30 -c 60"
  handlers ["default", "slack"]
  subscribers ["sensu-server", "sensu-client"]
  interval 30
  standalone false
  additional(
    :occurrences => 5,
    :refresh => 180
  )
end
