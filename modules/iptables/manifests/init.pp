class iptables {
	file {'/etc/iptables/':
		before  => File['/etc/iptables/iptables-init', '/etc/iptables/iptables-commands'],
		ensure  => directory,
		owner   => root,
		group   => root,
		mode    => 600,
		source  => [ "puppet:///modules/iptables/iptables_$clientcert", 'puppet:///modules/iptables/iptables' ],
		sourceselect => all,
		recurse => true,
	}
 	file {'/etc/iptables/iptables-init':
		owner   => root,
		group   => root,
		mode    => 700,
		source  => [ "puppet:///modules/iptables/iptables_$clientcert/iptables-init", 'puppet:///modules/iptables/iptables/iptables-init' ],
 	}
 	file {'/etc/iptables/iptables-commands':
		owner   => root,
		group   => root,
		mode    => 700,
		source  => [ "puppet:///modules/iptables/iptables_$clientcert/iptables-commands", 'puppet:///modules/iptables/iptables/iptables-commands' ],
 	}

	file {'/etc/rc.local':
		owner   => root,
		group   => root,
		mode    => 755,
		source  => [ "puppet:///modules/iptables/rc.local_$clientcert", 'puppet:///modules/iptables/rc.local' ],
	}

	exec {'/etc/rc.local':
		subscribe   => File['/etc/iptables/', '/etc/iptables/iptables-init', '/etc/iptables/iptables-commands', '/etc/rc.local'],
		refreshonly => true
	}
}
