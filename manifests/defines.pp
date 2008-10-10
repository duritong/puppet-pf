# manifests/defines.pp

# use this to deploy settings for 
# an authpf user
# if authpf isn't yet fully configured 
# puppet will automatically configure
# it for you.
# you can ensure a user to be:
# - present: access is allowed
# - absent: allow info is removed
# - banned: user is removed and banned, message 
#   $ban_message (define parameter) is
#   displayed.
define pf::authpf_user(
    $source = 'absent',
    $ensure = 'present',
    $ban_message = 'You have been banned from this system! For further infos, please ask the administration team!' 
){
    include pf::authpf

    $real_ensure = $ensure ? {
        'present' => 'present',
        default => 'absent'
    }

    file{"/etc/authpf/users/${name}":
        ensure => $real_ensure ? {
            'present' => directory,
            default => absent,
        },
        owner => root, group => 0, mode => 0750;
    }

    file{"/etc/authpf/users/${name}/autpf.rules":
        source => $source ? {
            'absent' => [ 
                        "puppet://$server/files/pf/authpf/users/${fqdn}/${name}",
                        "puppet://$server/files/pf/autpf/users/${pf_config_class}/${name}",    
                        "puppet://$server/files/pf/autpf/users/${name}"    
            ],
            default => "puppet://$server/${source}",
        },
        ensure => $ensure,
        owner => root, group => 0, mode => 0640;
    }

    line { "manage_${$name}_in_authpf.allow":
        file => '/etc/authpf/authpf.allow',
        line => "$name",
        ensure => $real_ensure,
    }

    case $ensure {
        'banned': {
            file{"/etc/authpf/banned/${name}":
                content => $ban_message,
                owner => root, group => 0, mode => 0640;
            }
        }
    }
}
