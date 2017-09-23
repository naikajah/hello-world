# == Class: webapp::config
# webapp::config - All the necessary minimal configuration required for web application servers.
#
# === Examples
#  include webapp::config
#
# === Authors
# Piyush Kumar <piyush.m82@gmail.com>
#

class webapp::config (
  $webapp_server_1 = '192.168.1.8',
  $webapp_server_2 = '192.168.1.6',
  $loadbalancer = '192.168.1.4',
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

  file {'/etc/nginx/sites-available/default':
    ensure  => present,
    group   => 'root',
    owner   => 'root',
    mode    => '0644',
    content => template("${module_name}/default.erb"),
  }

  file {'/usr/share/nginx/html/index.php':
    ensure => present,
    group  => 'root',
    owner  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/webapp/index.php',
  }

  # Allow 9000 port
  exec {'allow port 9000':
    command => "ufw allow 9000",
    path    => "/usr/sbin",
    user    => "root"
  }
}
