# modules/pf/manifests/init.pp - manage pf stuff
# Copyright (C) 2007 admin@immerda.ch
#

# $pf_config_class:
#  - define this to use a specific class folder
#    to deploy the config

import 'defines.pp'

class pf {
	line { "startpf_entry":
		file => "/etc/rc.conf.local",
		line => 'pf="YES"',
	}
	
	line { "pfconfig_loc_entry":
		file => "/etc/rc.conf.local",
		line => 'pf_rules=/etc/pf.conf',
	}

	package { 'pftop':
		ensure => 'present',
	}

	file { 'pf_config':
		path => '/etc/pf.conf',
		owner => root,
		group => 0,
		mode => 600,
		source => [ "puppet://$server/files/pf/${fqdn}/pf.conf",
		            "puppet://$server/files/pf/${pf_config_class}/pf.conf",
		            "puppet://$server/files/pf/pf.conf",
                    "puppet://$server/pf/pf.conf" ],
		notify => Exec[pf_load],
	}

	exec { "pf_load":
        onlyif => '/sbin/pfctl -nf /etc/pf.conf',
		command => '/sbin/pfctl -f /etc/pf.conf',
		refreshonly => true,
	}

	exec { "pf_activate":
		command => '/sbin/pfctl -e',
        unless => '/sbin/pfctl -s all | /usr/bin/grep -q "Status: Enabled"',
	}
    
    if $use_munin {
        include pf::munin
    }
}
