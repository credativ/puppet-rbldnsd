# Define defaults for the rbldnsd module
class rbldnsd::params {
    # Module options
    $ensure             = present
    $ensure_running     = true
    $ensure_enabled     = true
    $manage_config      = true
    $config_template    = 'rbldnsd/rbldnsd.conf.erb'
    $config_source      = undef
    $disabled_hosts     = []
    $zones              = []

}
