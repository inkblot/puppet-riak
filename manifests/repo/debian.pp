# ex: syntax=puppet si ts=4 sw=4 et

class riak::repo::debian {
	apt::key { 'basho':
		key        => 'DDF2E833',
		key_server => 'keyserver.ubuntu.com',
	}

	apt::source { 'basho':
		location    => 'http://apt.basho.com',
		release     => $::lsbdistcodename,
		repos       => 'main',
        include_src => false,
		require     => Apt::Key['basho'],
	}
}
