# ex: syntax=puppet si ts=4 sw=4 et

class riak::repo {
    $platform = downcase($::osfamily)
	class { "riak::repo::${platform}":
        before => Anchor['riak::repo::finish'],
    }
    anchor { 'riak::repo::finish': }
}
