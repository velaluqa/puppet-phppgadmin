![Build Status](https://travis-ci.org/velaluqa/puppet-phppgadmin.svg)

# UNMAINTAINED

Since we stopped using puppet for our infrastructure, we are not going to 
maintain this solution anymore.

# Puppet-phppgadmin

A puppet module to easily deploy phppgadmin. Make sure you have a
correct php5 installation. This module only clones the latest
phppgadmin repository state and creates the correct configuration
file.

You may have to install `php5-fpm` (via puppet-php) and configure your
web server (e.g. puppet-nginx)

## Suggested Preparation

This module is as simple as possible. You should be able to choose
your own php installation. This is my own, which works quite find, as
I find:

1. First I install the
   [nodes/php](https://forge.puppetlabs.com/nodes/php) module.

```
puppet module install nodes/php
```

2. Using this module I install the necessary php packages. For serving
   php I use php-fpm with nginx.

```
class { 'php::extension::pgsql': }
class { 'php::extension::mcrypt': }
class { 'php::fpm::daemon':
  ensure => running
}
```

3. Then I install phppgadmin. See [[Usage]].

4. At last you may set up your vhost. This is depending on the server
   module you are using.

## Usage

```
  class { 'phppgadmin':
    path => "/srv/phppgadmin",
    user => "www-data",
    servers => [
      {
        desc => "local",
        host => "127.0.0.1",
      },
      {
        desc => "other",
        host => "192.168.1.30",
      }
    ]
  }
```

## Contribute

Want to help - send a pull request.
