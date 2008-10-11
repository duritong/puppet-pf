# manifests/router.pp

# this class will automatically
# add the nedded sysctl calls to
# do routing.
class pf::router inherits pf {
    include openbsd::router
}
