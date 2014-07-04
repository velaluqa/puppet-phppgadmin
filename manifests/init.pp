# == Class: phppgadmin
#
# === Parameters
#
# [path] The path to install phppgadmin to (default: /srv/phpgadmin)
# [user] The user that should own that directory (default: www-data)
# [servers] An array of servers (default: [])
# [revision] The revision for the deployment (default: 'origin/REL_5-1')
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
#    ],
#    depth = 0
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
  $path = '/srv/phppgadmin',
  $user = 'www-data',
  $servers = [],
  $revision = 'origin/REL_5-1',
  $depth = 0,
) {
  file { $path:
    ensure         => directory,
    owner          => $user,
  }
  ->
  vcsrepo { $path:
    ensure   => present,
    provider => git,
    source   => 'git://github.com/phppgadmin/phppgadmin.git',
    user     => $user,
    revision => $revision,
    depth    => $depth,
  }
  ->
  file { 'phppgadmin-conf':
    path    => "${path}/conf/config.inc.php",
    content => template('phppgadmin/config.inc.php.erb'),
    owner   => $user,
  }
} # Class:: phppgadmin
