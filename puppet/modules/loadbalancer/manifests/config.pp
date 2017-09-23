# == Class: loadbalancer::config
# loadbalancer::config - Loadbalancer Configuration.
#
# === Examples
#  include loadbalancer::config
#
# === Authors
# Piyush Kumar <piyush.m82@gmail.com>
#

class loadbalancer::config (
  $webapp_server_1 = '192.168.1.8',
  $webapp_server_2 = '192.168.1.6',
  $loadbalancer    = '192.168.1.4',
  $backend_servers = hiera("loadbalancer::backend")
  ){

  host { 'webapp-1.test.com':
    ip     => $webapp_server_1,
    ensure => present
  }

  host { 'webapp-2.test.com':
    ip     => $webapp_server_2,
    ensure => present
  }

  host { 'loadbalancer.test.com':
    ip     => $loadbalancer,
    ensure => present
  }

  file {'/etc/nginx/nginx.conf':
    ensure  => present,
    group   => 'root',
    owner   => 'root',
    mode    => '0644',
    content => template("${module_name}/nginx.conf.erb"),
  }

  file {'/etc/nginx/sites-available/default':
    ensure  => present,
    group   => 'root',
    owner   => 'root',
    mode    => '0644',
    content => template("${module_name}/default.erb"),
  }

  file {'/etc/nginx/naxsi.rules':
    ensure => present,
    group  => 'root',
    owner  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/loadbalancer/naxsi.rules',
  }
}
