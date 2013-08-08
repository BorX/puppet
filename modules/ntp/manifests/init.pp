class ntp {
	package {'ntp':}
/*
	file { '/etc/ntp.conf':
		require => Package['ntp'],
		source  => 'puppet:///modules/ntp/ntp.conf',
		owner   => root,
		group   => root,
		mode    => 0644,
		notify  => Service['ntp'],
	}
*/
	service { 'ntp': 
		require => Package['ntp'],
		ensure     => running,
		enable     => true,
		hasstatus  => true,
		hasrestart => true
	}
}
