# modules/pf/manifests/init.pp - manage pf stuff
# Copyright (C) 2007 admin@immerda.ch
#

# $pf_config_class:
#  - define this to use a specific class folder
#    to deploy the config
class pf (
  $pf_config_class = hiera('pf_config_class', '')
) {
  file_line {
    'startpf_entry' :
      path => '/etc/rc.conf.local',
      line => 'pf="YES"';

    'pfconfig_loc_entry' :
      path => '/etc/rc.conf.local',
      line => 'pf_rules=/etc/pf.conf';
  }
  package {
    'pftop' :
      ensure => 'present',
  }
  file {
    'pf_config' :
      path => '/etc/pf.conf',
      owner => root,
      group => 0,
      mode => 600,
      source => [
        "puppet:///modules/site_pf/${::fqdn}/pf.conf",
        "puppet:///modules/site_pf/${pf::pf_config_class}/pf.conf",
        "puppet:///modules/site_pf/pf.conf", "puppet:///modules/pf/pf.conf"
      ],
      notify => Exec[pf_test];
  }
  exec {
    'pf_test' :
      command => 'pfctl -nf /etc/pf.conf',
      refreshonly => true,
      notify => Exec[pf_load] ;

    'pf_load' :
      command => 'pfctl -f /etc/pf.conf',
      refreshonly => true ;

    'pf_activate' :
      command => '/sbin/pfctl -e',
      unless => '/sbin/pfctl -s all | /usr/bin/grep -q "Status: Enabled"' ;
  }
  if hiera('use_munin', false) {
    include pf::munin
  }
}
