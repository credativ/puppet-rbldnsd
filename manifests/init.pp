# = Class: rbldnsd
#
# Module to manage rbldnsd
#
# == Requirements:
#
# - This module makes use of the example42 functions in the puppi module
#   (https://github.com/credativ/puppet-example42lib)
#
# == Parameters:
#
# [* ensure *]
#   What state to ensure for the package. Accepts the same values
#   as the parameter of the same name for a package type.
#   Default: present
#
# [* ensure_running *]
#   Weither to ensure running rbldnsd or not.
#   Default: running
#
# [* ensure_enabled *]
#   Weither to ensure that rbldnsd is started on boot or not.
#   Default: true
#
# [* config_source *]
#   Specify a configuration source for the configuration. If this
#   is specified it is used instead of a template-generated configuration
#
# [* config_template *]
#   Override the default choice for the configuration template
#
# [* disabled_hosts *]
#   A list of hosts whose rbldnsd will be disabled, if their
#   hostname matches a name in the list.
# 
# [* listener *]
#   Specify on which interface/ip rbldnsd should listen
#
# [* zones *]
#   Specify the zones that should be managed by rbldnsd
#   (Default: 127.0.0.1)
#
# == Author:
#
#   Patrick Schoenfeld <patrick.schoenfeld@credativ.de>

class rbldnsd (
    $ensure             = params_lookup('ensure'),
    $manage_config      = params_lookup('manage_config'),
    $ensure_running     = params_lookup('ensure_running'),
    $ensure_enabled     = params_lookup('ensure_enabled'),
    $config_source      = params_lookup('config_source'),
    $config_template    = params_lookup('config_template'),
    $disabled_hosts     = params_lookup('disabled_hosts'),
    $zones              = params_lookup('zones'),
    $listener           = params_lookup('listener'),
    ) inherits rbldnsd::params {

    package { 'rbldnsd':
        ensure => $ensure
    }

    service { 'rbldnsd':
        ensure      => $ensure_running,
        enable      => $ensure_enabled,
        hasrestart  => true,
        require     => Package['rbldnsd']
    }

    # Disable service on this host, if hostname is in disabled_hosts
    if $::hostname in $disabled_hosts {
        Service <| title == 'rbldnsd' |> {
            ensure  => 'stopped',
            enabled => false,
        }
    }

    file { '/etc/default/rbldnsd':
        ensure  => present,
        mode    => '0644',
        owner   => 'root',
        group   => 'root',
        tag     => 'rbldnsd_config',
        require => Package['rbldnsd'],
        notify  => Service['rbldnsd']
    }

    if $config_source {
        File <| tag == 'rbldnsd_config' |> {
            source  => $config_source
        }
    } else {
        if $zones {
            File <| tag == 'rbldnsd_config' |> {
                content => template($config_template)
            }
        } else {
            fail('No zones defined in backend')
        }
    }

}
