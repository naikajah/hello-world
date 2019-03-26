# == Class: webapp::package
# webapp::package - All the pacakges to be deployed for web application.
#
# === Examples
#  include webapp::package
#
# === Authors
# Piyush Kumar <piyush.m82@gmail.com>
#

class webapp::package {

  package { 'nginx':
    ensure   => present,
    provider => 'apt'
  }

  package { ['php7.0-fpm',
             'php7.0-cli']:
    ensure => present,
    provider => 'apt',
  }

}
