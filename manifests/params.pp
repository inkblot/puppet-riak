# ex: syntax=puppet si ts=4 sw=4 et

class riak::params {
    $package_name         = 'riak'
	$manage_repo          = false
    $version              = latest
    $service_name         = 'riak'
    $pb_backlog           = '64'
    $pb_ipaddress         = '127.0.0.1'
    $http_secure          = false
    $http_address         = '127.0.0.1'
    $http_port            = '8098'
    $https_cert           = '/etc/riak/cert.pem'
    $https_key            = '/etc/riak/key.pem'
    $handoff_port         = '8099'
    $default_bucket_props = {}
    $kv_add_paths         = []
    $kv_storage_backend   = 'riak_kv_bitcask_backend'
    $kv_multi_backend     = {}
    $vm_ipaddress         = '127.0.0.1'
    $join_cluster         = ''
}
