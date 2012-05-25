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
# Please note: the appropriate pf-rules you have to
# add one your own!
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
        owner => $name, group => 0, mode => 0750;
    }

    file{"/etc/authpf/users/${name}/authpf.rules":
        source => $source ? {
            'absent' => [
                        "puppet:///modules/site_pf/authpf/users/${::fqdn}/${name}",
                        "puppet:///modules/site_pf/authpf/users/${pf::pf_config_class}/${name}",
                        "puppet:///modules/site_pf/authpf/users/${name}"
            ],
            default => "puppet:///${source}",
        },
        ensure => $ensure,
        owner => $name, group => 0, mode => 0640;
    }

    file_line { "manage_${$name}_in_authpf.allow":
        path => '/etc/authpf/authpf.allow',
        line => "$name",
        ensure => $real_ensure,
    }

    case $ensure {
        'banned': {
            file{"/etc/authpf/banned/${name}":
                content => $ban_message,
                owner => $name, group => 0, mode => 0640;
            }
        }
    }
}
