# manifests/munin.pp

class pf::munin {
    munin::plugin::deploy{'pf': 
        source => "puppet://$server/pf/munin/pf" ,
        config => 'user root',
    }
    munin::plugin::deploy{'pf_bytes':
        source => "puppet://$server/pf/munin/pf_bytes",
        config => 'user root',
     }
    munin::plugin::deploy{'pf_packets':
        source => "puppet://$server/pf/munin/pf_packets",
        config => 'user root',
    }
    munin::plugin::deploy{'pf_searches':
        source => "puppet://$server/pf/munin/pf_searches",
        config => 'user root',
    }
    munin::plugin::deploy{'pf_states':
        source => "puppet://$server/pf/munin/pf_states",
        config => 'user root',
    }
}
