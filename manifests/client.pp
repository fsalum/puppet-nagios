# Class: nagios::client
#
class nagios::client (
  $nrpe_cfg_template = 'nagios/nrpe_cfg.erb',
  $nrpe_sysconfig    = '',
) {

  include nagios::params

  $nagios_client_package  = $nagios::params::nagios_client_package
  $nagios_client_service  = $nagios::params::nagios_client_service

  package { $nagios_client_package:
    ensure  => present,
  }

  service { $nagios_client_service:
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Package[$nagios_client_package],
  }

  file { '/etc/nagios/nrpe.cfg':
    path    => '/etc/nagios/nrpe.cfg',
    content => template($nrpe_cfg_template),
    owner   => root,
    group   => root,
    mode    => '0644',
    require => Package[$nagios_client_package],
    notify  => Service[$nagios_client_service],
  }

  file { '/etc/sysconfig/nrpe':
    path    => '/etc/sysconfig/nrpe',
    content => template('nagios/nrpe_sysconfig.erb'),
    owner   => root,
    group   => root,
    mode    => '0644',
    require => Package[$nagios_client_package],
    notify  => Service[$nagios_client_service],
  }

}
