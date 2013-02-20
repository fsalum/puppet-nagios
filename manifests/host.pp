# Generic nagios::host class to be used.
# 
# You should prefer setting @@nagios_host per group of nodes
# based on it hostgroups parameter.
class nagios::host {

  @@nagios_host { $::fqdn:
    ensure     => present,
    use        => 'linux-server',
    alias      => $::hostname,
    address    => $::ipaddress,
    hostgroups => 'linux-servers',
    #target     => "/etc/nagios/resource.d/host_$::fqdn.cfg",
  }

}
