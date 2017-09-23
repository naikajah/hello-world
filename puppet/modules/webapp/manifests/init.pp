# == Class: webapp
# webapp - Default class to be included for web application.
#
# === Examples
#  include webapp
#
# === Authors
# Piyush Kumar <piyush.m82@gmail.com>
#

class webapp {

  anchor { 'webapp::begin':}->
  class { 'webapp::package': } ->
  class { 'webapp::config': } ~>
  class { 'webapp::service': }
  anchor { 'webapp::end': }

}
