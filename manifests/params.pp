# Class: nagios::params
#
# This class configures parameters for the puppet-nagios module.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class nagios::params {

  case $::operatingsystem {
    'centos', 'redhat', 'fedora': {
      $nagios_server_package = [ 'nagios', 'nagios-devel', 'nagios-plugins-nrpe', 'nagios-plugins' ]
      $nagios_server_service = 'nagios'
      $nagios_client_package = [ 'nagios-plugins-all', 'nagios-common', 'nrpe', 'perl-Nagios-NSCA' ]
      $nagios_client_service = 'nrpe'
      $nagios_conf_dir       = '/etc/nagios'
      $nrpe_conf_dir         = '/etc/nrpe.d'
    }
    'ubuntu', 'debian': {
      $nagios_server_package = [ 'nagios3', 'nagios-nrpe-plugin' ]
      $nagios_server_service = 'nagios3'
      $nagios_client_package = [ 'nagios-plugins', 'nagios-plugins-basic', 'nagios-plugins-standard', 'nagios-nrpe-server' ]
      $nagios_client_service = 'nagios-nrpe-server'
      $nagios_conf_dir       = '/etc/nagios3'
      $nrpe_conf_dir         = '/etc/nagios/nrpe.d'
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem: ${::operatingsystem}, module ${module_name} only support osfamily RedHat and Debian")
    }
  }

}
