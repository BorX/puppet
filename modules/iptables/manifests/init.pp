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
	-> file {'/etc/iptables/iptables-init':
		owner   => root,
		group   => root,
		mode    => 700,
		source  => [ "puppet:///modules/iptables/iptables_$clientcert/iptables-init", 'puppet:///modules/iptables/iptables/iptables-init' ],
	}
	-> file {'/etc/iptables/iptables-commands':
		owner   => root,
		group   => root,
		mode    => 700,
		source  => [ "puppet:///modules/iptables/iptables_$clientcert/iptables-commands", 'puppet:///modules/iptables/iptables/iptables-commands' ],
	}
	-> file {'/etc/init.d/iptables':
		owner   => root,
		group   => root,
		mode    => 755,
		content => '#!/bin/sh
### BEGIN INIT INFO
# Provides:          iptables-init
# Required-Start:
# Required-Stop:
# Default-Start:     2 3 4 5
# Default-Stop:
# Short-Description: Initialize iptables rules
# Description:       Initialization of iptables rules.
### END INIT INFO
/etc/iptables/iptables-init $1',
	}
}
