# manifests/munin.pp

class pf::munin {
    munin::remoteplugin{'pf': source => "puppet://$server/pf/munin/pf" }
    munin::remoteplugin{'pf_bytes': source => "puppet://$server/pf/munin/pf_bytes" }
    munin::remoteplugin{'pf_packets': source => "puppet://$server/pf/munin/pf_packets" }
    munin::remoteplugin{'pf_searches': source => "puppet://$server/pf/munin/pf_searches" }
    munin::remoteplugin{'pf_states': source => "puppet://$server/pf/munin/pf_states" }
}
