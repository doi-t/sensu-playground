name             'sensu-wrapper'
maintainer       'toshiya doi'
maintainer_email 'doi.t.npdp@gmail.com'
license          'All rights reserved'
description      'Installs/Configures sensu server and client'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends          'sensu'
depends          'uchiwa'
depends          'ntp'
