# == Class: phppgadmin
#
# === Parameters
#
# [path] The path to install phppgadmin to (default: /srv/phpgadmin)
# [user] The user that should own that directory (default: www-data)
# [servers] An array of servers (default: [])
#
# === Examples
#
#  class { 'phppgadmin':
#    path => "/srv/phppgadmin",
#    user => "www-data",
#    servers => [
#      {
#        desc => "local",
#        host => "127.0.0.1",
#      },
#      {
#        desc => "other",
#        host => "192.168.1.30",
#      }
#    ]
#  }
#
# === Authors
#
# Arthur Leonard Andersen <leoc.git@gmail.com>
#
# === Copyright
#
# See LICENSE file, Arthur Leonard Andersen (c) 2013

# Class:: phppgadmin
#
#
class phppgadmin (
  $path = "/srv/phppgadmin",
  $user = "www-data",
  $servers = []
) {
  file { $path:
    ensure => "directory",
    owner => $user,
  }

  exec { "phppgadmin-checkout":
    path => "/bin:/usr/bin",
    creates => "$path/.git",
    command => "git clone git://github.com/phppgadmin/phppgadmin.git ${path}",
    require => File[$path],
    user => $user,
  }

  exec { "phppgadmin-upgrade":
    path => "/bin:/usr/bin",
    command => "bash -c 'cd ${path}; git fetch; git checkout origin/REL_5-0'",
    require => Exec["phppgadmin-checkout"],
    user => $user,
  }

  file { "phppgadmin-conf":
    path => "$path/conf/config.inc.php",
    content => template("phppgadmin/config.inc.php.erb"),
    owner => $user,
    require => Exec["phppgadmin-upgrade"],
  }
} # Class:: phppgadmin
