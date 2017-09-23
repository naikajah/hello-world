# == Class: sudoers
# sudoers - This call updates the sudoers file so that the vagrant user is allowed sudo access without password.
# where as any other admin group members should be asked for password for sudo.
# === Examples
#  include sudoers
#
# === Authors
# Piyush Kumar <piyush.m82@gmail.com>
#

class sudoers {

  file { '/etc/sudoers':
      source => 'puppet:///modules/sudoers/sudoers',
      mode => '0440',
      owner => 'root',
      group => 'root',
    }

}
