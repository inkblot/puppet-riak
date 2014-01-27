# ex: syntax=puppet si ts=4 sw=4 et

class riak (
    $package_name         = $::riak::params::package_name,
    $manage_repo          = $::riak::params::manage_repo,
    $version              = $::riak::params::version,
    $service_name         = $::riak::params::service_name,
    $pb_backlog           = $::riak::params::pb_backlog,
    $pb_ipaddress         = $::riak::params::pb_ipaddress,
    $http_secure          = $::riak::params::http_secure,
    $http_address         = $::riak::params::http_address,
    $http_port            = $::riak::params::http_port,
    $https_cert           = $::riak::params::https_cert,
    $https_key            = $::riak::params::https_key,
    $handoff_port         = $::riak::params::handoff_port,
    $default_bucket_props = $::riak::params::default_bucket_props,
    $kv_add_paths         = $::riak::params::kv_add_paths,
    $kv_storage_backend   = $::riak::params::kv_storage_backend,
    $kv_multi_backend     = $::riak::params::kv_multi_backend,
    $vm_ipaddress         = $::riak::params::vm_ipaddress,
    $join_cluster         = $::riak::params::join_cluster,
) inherits riak::params {

    File {
        ensure  => present,
        owner   => 'riak',
        group   => 'riak',
        mode    => '0644',
    }

    if $manage_repo {
        include riak::repo
        Class['riak::repo'] -> Package['riak']
    }

    package { 'riak':
        name => $package_name,
        ensure => $version,
    }

    user { 'riak':
        ensure  => present,
        gid     => 'riak',
        require => Package['riak'],
    }

    group { 'riak':
        ensure  => present,
        require => Package['riak'],
    }

    file { '/etc/riak/app.config':
        content => template('riak/app.config.erb'),
        require => Package['riak'],
        notify  => Service['riak'],
    }

    file { '/etc/riak/vm.args':
        content => template('riak/vm.args.erb'),
        require => Package['riak'],
        notify  => Service['riak'],
    }

    service { 'riak':
        name      => $service_name,
        ensure    => running,
    }

    if $join_cluster != '' {
        class { 'riak::join_cluster':
            cluster_address => $join_cluster,
        }
    }
}
