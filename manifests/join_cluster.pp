# ex: syntax=puppet si ts=4 sw=4 et

class riak::join_cluster (
    $cluster_address,
) {
    Exec {
        user        => 'root',
        refreshonly => true,
        require     => Service['riak'],
    }

    exec { 'riak cluster join':
        command   => "/usr/sbin/riak-admin cluster join riak@${cluster_address}",
        subscribe => File['/etc/riak/vm.args'],
        notify    => Exec['riak cluster plan'],
    }

    exec { 'riak cluster plan':
        command => '/usr/sbin/riak-admin cluster plan',
        notify  => Exec['riak cluster commit'],
    }

    exec { 'riak cluster commit':
        command => '/usr/sbin/riak-admin cluster commit',
    }
}
