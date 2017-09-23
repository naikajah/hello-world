# == Class: loadbalancer
# loadbalancer - Main manifest to be included for loadbalancer.
#
# === Examples
#  include loadbalancer
#
# === Authors
# Piyush Kumar <piyush.m82@gmail.com>
#

class loadbalancer {

  anchor { 'loadbalancer::begin':}->
  class { 'loadbalancer::package': } ->
  class { 'loadbalancer::config': } ~>
  class { 'loadbalancer::service': }
  anchor { 'loadbalancer::end': }

}
