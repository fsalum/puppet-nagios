Nagios
======

Simple nagios module to install Nagios Server, Nagios client and configure some exported resources for services, hostgroups and hosts.

Starting point if you need a base nagios setup working with Puppet

    node basenode {
      class { 'nagios::client':
        nrpe_sysconfig    => '-n',
        nrpe_cfg_template => 'nagios/nrpe.cfg.erb',                
    }
    
    node 'nagios-server' inherits basenode {
      include nagios::server
      include nagios::host
      include nagios::service
      include nagios::hostgroup
    }
    
    # Using the generic @@nagios_host
    node 'nagios-client-1' inherits basenode {
      include nagios::host
    }
    
    # Best to setup your individual @@nagios_host per group of nodes/hostgroups
    node 'nagios-client-2' inherits basenode {
      @@nagios_host { $::fqdn:
        ensure     => present,
        use        => 'linux-server',
        alias      => $::hostname,
        address    => $::ipaddress,
        hostgroups => 'db-servers, linux-servers',
      }
    }
    
