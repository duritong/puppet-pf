# manifests/authpf.pp

# to use authpf you can directly
# use: pf::authpf_users these settings
# will automatically be applied.
#
# you can set the following 
# variables to change messages:
#
# - $authpf_problem_msg: sets the problem message
# - $authpf_msg: sets the message displayed after 
#                authentication
class pf::authpf {

    include pf

    file{'/etc/authpf/':
        source => "puppet://$server/common/empty",
        ignore => '\.ignore',
        ensure => directory,
        recurse => true,
        purge => true,
        owner => root, group => 0, mode => 0640;
    }

    file{ [ '/etc/authpf/users', '/etc/authpf/banned/' ]:
        ensure => directory,
        owner => root, group => 0, mode => 0750;
    }

    file{ [ '/etc/authpf/authpf.allow', '/etc/authpf/authpf.conf']:
        ensure => present,
        owner => root, group => 0, mode => 0640;
    }

    file{'/etc/authpf/authpf.problem':
        content => $authpf_problem_msg ? {
                '' => 'Sorry, some bad things are going on... Please look after me!',
                default => $authpf_auth_msg,
        },
        owner => root, group => 0, mode => 0640;
    }
        
    file{'/etc/authpf/authpf.message':
        content => $authpf_msg ? {
                '' => "You're ready to authenticate on the hosts... 
Don't do anything stupid!
Don't forget to document your changes! ;) 
Happy hacking!\n",
                default => $authpf_auth_msg,
        },
        owner => root, group => 0, mode => 0640;
    }
        
}
