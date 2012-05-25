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
class pf::authpf(
  $authpf_msg = hiera('authpf_msg',"You're ready to authenticate on the hosts...
Don't do anything stupid!
Don't forget to document your changes! ;)
Happy hacking!\n"),
  $authpf_problem_msg = hiera('authpf_problem_msg', 'Sorry, some bad things are going on... Please look after me!')
){

    include pf

    file{
      '/etc/authpf':
        ensure => directory,
        recurse => true,
        purge => true,
        owner => root, group => 0, mode => 0644;

      [ '/etc/authpf/users', '/etc/authpf/banned' ]:
        ensure => directory,
        owner => root, group => 0, mode => 0755;

      [ '/etc/authpf/authpf.allow', '/etc/authpf/authpf.conf']:
        ensure => present,
        owner => root, group => 0, mode => 0644;

      '/etc/authpf/authpf.problem':
        content => $pf::authpf::authpf_problem_msg,
        owner => root, group => 0, mode => 0644;
      '/etc/authpf/authpf.message':
        content => $pf::authpf::authpf_msg,
        owner => root, group => 0, mode => 0644;
    }
}
