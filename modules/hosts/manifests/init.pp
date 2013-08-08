class hosts {
 	file {'/etc/hosts':
		owner   => root,
		group   => root,
		mode    => 644,
		source  => [ "puppet:///modules/hosts/hosts_$clientcert", 'puppet:///modules/hosts/hosts' ],
 	}
}
