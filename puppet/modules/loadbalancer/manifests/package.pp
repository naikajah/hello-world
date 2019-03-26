# == Class: loadbalancer::package
# loadbalancer::package - Packages to be deployed for loadbalancer.
#
# === Examples
#  include loadbalancer::package
#
# === Authors
# Piyush Kumar <piyush.m82@gmail.com>
#

class loadbalancer::package {

  package {'nginx':
    ensure   => present,
    provider => 'apt'
  }

}
