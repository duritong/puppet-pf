# manifests/munin.pp

class pf::munin {
    munin::remoteplugin{'pf': 
        source => "puppet://$server/pf/munin/pf" ,
        config => 'user root',
    }
    munin::remoteplugin{'pf_bytes':
        source => "puppet://$server/pf/munin/pf_bytes",
        config => 'user root',
     }
    munin::remoteplugin{'pf_packets':
        source => "puppet://$server/pf/munin/pf_packets",
        config => 'user root',
    }
    munin::remoteplugin{'pf_searches':
        source => "puppet://$server/pf/munin/pf_searches",
        config => 'user root',
    }
    munin::remoteplugin{'pf_states':
        source => "puppet://$server/pf/munin/pf_states",
        config => 'user root',
    }
}
