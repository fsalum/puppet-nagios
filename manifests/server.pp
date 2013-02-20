#
# Class: nagios::server
#
class nagios::server {

  include nagios::params

  $nagios_server_package  = $nagios::params::nagios_server_package
  $nagios_server_service  = $nagios::params::nagios_server_service

  package { $nagios_server_package:
    ensure  => present,
  }

  service { $nagios_server_service:
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Package[$nagios_server_package],
  }

  file { '/etc/nagios/nagios.cfg':
    path   => '/etc/nagios/nagios.cfg',
    source => 'puppet:///modules/nagios/etc/nagios/nagios.cfg',
    owner  => root,
    group  => root,
    mode   => '0644',
  }

  # Not using target for exported resources yet. But it is here just in case.
  file { '/etc/nagios/resource.d':
    ensure  => directory,
    path    => '/etc/nagios/resource.d',
    owner   => 'nagios',
    #recurse => true,
    #purge   => true,
  }

  # Collect the nagios resources
  Nagios_host <<||>> {
    require => File['/etc/nagios/resource.d'],
    notify  => Service[$nagios_server_service],
  }

  Nagios_service <<||>> {
    require => File['/etc/nagios/resource.d'],
    notify  => Service[$nagios_server_service],
  }

  Nagios_hostgroup <<||>> {
    require => File['/etc/nagios/resource.d'],
    notify  => Service[$nagios_server_service],
  }

  # Remove deactivate nodes
  resources { [ 'nagios_service', 'nagios_hostgroup', 'nagios_host' ]:
    purge  => true,
    notify => Service[$nagios_server_service],
  }

}
