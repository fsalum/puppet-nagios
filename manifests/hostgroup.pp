# All nagios hostgroups should be added here.
# 
# This class must be added to the nagios server only.
class nagios::hostgroup {

  @@nagios_hostgroup { 'app-server':
    ensure         => present,
    alias          => 'App Servers',
    hostgroup_name => 'app-servers',
    #target         => "/etc/nagios/resource.d/hostgroup.cfg",
  }

  @@nagios_hostgroup { 'qa-server':
    ensure         => present,
    alias          => 'QA Servers',
    hostgroup_name => 'qa-servers',
    #target         => "/etc/nagios/resource.d/hostgroup.cfg",
  }

}
