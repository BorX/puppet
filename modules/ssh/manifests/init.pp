class ssh {
	require users
	package {'openssh-server':}
	file {'/etc/ssh/sshd_config':
		require => Package['openssh-server'],
		source  => [ "puppet:///modules/ssh/sshd_config_$clientcert", 'puppet:///modules/ssh/sshd_config' ],
		owner   => 'root',
		group   => 'root',
		mode    => '0640',
		notify  => Service['ssh']
	}
	service {'ssh':
		ensure     => running,
		enable     => true,
		hasstatus  => true,
		hasrestart => true
	}
}
