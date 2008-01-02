# modules/pf/manifests/init.pp - manage pf stuff
# Copyright (C) 2007 admin@immerda.ch
#

modules_dir { "pf": }

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
		source => 'ftp://mirror.switch.ch/pub/OpenBSD/4.2/packages/i386/pftop-0.6.tgz',
	}
}

define pf::deploy_config( $source ){

	file { 'pf_config':
		path => '/etc/pf.conf',
		owner => 'root',
		group => 0,
		mode => 600,
		source => "puppet://$server/pf/${source}",
		notify => Exec[pf_activate],
	}

	exec { "pf_test":
		command => '/sbin/pfctl -nf /etc/pf.conf',
		refreshonly => true,
	}

	exec { "pf_load";
		command => '/sbin/pfctl -f /etc/pf.conf'
		refreshonly => true,
		require => Exec[pf_test],
	}

	exec { "pf_activate":
		command => '/sbin/pfctl -e',
		refreshonly => true,
		require => Exec[pf_load],
	}
}
