# == Class: loadbalancer::service
# loadbalancer::service - Loadbalancer service manifest for ensuring running services.
#
# === Examples
#  include loadbalancer::service
#
# === Authors
# Piyush Kumar <piyush.m82@gmail.com>
#

class loadbalancer::service {

  service { 'nginx':
   ensure   => running,
  }
}
