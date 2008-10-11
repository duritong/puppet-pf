# manifests/bruteforce.pp

class pf::bruteforce {
    cron { 'cleanup_bruteforce_table':
        command => 'pfctl -q -t bruteforce -T expire 3600',
        minute => '*/10',
    } 
}
