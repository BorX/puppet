class users {
	package {'sudo':}
	group {'borx':
		ensure => present,
		gid    => '1000',
	}
	user {'borx':
		require    => [ Package['sudo'], Group['borx'] ],
		ensure     => present,
		uid        => '1000',
		gid        => 'borx',
		groups     => 'sudo',
		shell      => '/bin/bash',
		home       => '/home/borx',
		managehome => true,
	}
}
