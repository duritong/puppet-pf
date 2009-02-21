# manifests/munin.pp

class pf::munin {
    munin::plugin::deploy{'pf': 
        source => "pf/munin/pf" ,
        config => 'user root',
    }
    munin::plugin::deploy{'pf_bytes':
        source => "pf/munin/pf_bytes",
        config => 'user root',
     }
    munin::plugin::deploy{'pf_packets':
        source => "pf/munin/pf_packets",
        config => 'user root',
    }
    munin::plugin::deploy{'pf_searches':
        source => "pf/munin/pf_searches",
        config => 'user root',
    }
    munin::plugin::deploy{'pf_states':
        source => "pf/munin/pf_states",
        config => 'user root',
    }
}
