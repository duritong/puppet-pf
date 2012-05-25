# manifests/munin.pp

class pf::munin {
    munin::plugin::deploy{
      'pf':
        source => "pf/munin/pf" ,
        config => 'user root';

      'pf_bytes':
        source => "pf/munin/pf_bytes",
        config => 'user root';

      'pf_packets':
        source => "pf/munin/pf_packets",
        config => 'user root';

      'pf_searches':
        source => "pf/munin/pf_searches",
        config => 'user root';

      'pf_states':
        source => "pf/munin/pf_states",
        config => 'user root';
    }
}
