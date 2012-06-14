# manifests/router.pp

# this class will automatically
# add the nedded sysctl calls to
# do routing.
class pf::router (
  $config_class,
  $manage_munin = false
) {
  class { 'pf':
    config_class => $config_class,
    manage_munin => $manage_munin
  }
  include openbsd::router
}
