maintainer       'James Conroy-Finn'
maintainer_email 'james@logi.cl'
license          'Apache 2.0'
description      'Configures my box'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.1'

%w( dmg homebrew ).each { |x| depends x }
