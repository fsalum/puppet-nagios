# All nagios services should be added here.
# 
# This class must be added to the nagios server only.
class nagios::service {

  @@nagios_service { 'check_ping':
    ensure              => present,
    use                 => 'local-service',
    service_description => 'PING',
    check_command       => 'check_ping!100.0,20%!500.0,60%',
    hostgroup_name      => 'linux-servers,app-servers',
    #target              => "/etc/nagios/resource.d/service_check_ping_$::fqdn.cfg",
  }

}
