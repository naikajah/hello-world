# == Class: webapp::service
# webapp::service - Services that shoudl be started.
#
# === Examples
#  include webapp::service
#
# === Authors
# Piyush Kumar <piyush.m82@gmail.com>
#

class webapp::service {

  service { 'nginx':
   ensure   => running,
  }

  service { 'php7.0-fpm':
    ensure => running,
    require => Package['php7.0-fpm'],
  }
}
