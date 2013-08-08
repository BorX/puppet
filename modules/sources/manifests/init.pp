class apt_defaults {
	$apt_dir = '/etc/apt'
	$sources_dir = "${apt_dir}/sources.list.d"
	$apt_conf_dir = "${apt_dir}/apt.conf.d"

	exec { 'aptitude-update':
		command     => '/usr/bin/aptitude update',
		refreshonly => true;
	}

/*	cron { 'aptitude-update':
		command => '/usr/bin/aptitude update',
		user    => root,
		hour    => 07,
		minute  => 00;
	}*/
 	file {'/etc/cron.daily/BorXAutoUpdate':
		owner   => root,
		group   => root,
		mode    => 755,
		content => '#!/bin/bash

#aptitude autoclean
aptitude clean
aptitude update
aptitude safe-upgrade -yd',
 	}

	# I don't want kernel upgrades to happen automatically, since I need to schedule reboots around others' work:
	#exec { "hold-kernels":
	#  command => "for name in `dpkg --get-selections | grep linux-image | grep -v hold | awk '{print \$1}'`; do echo \$name hold | dpkg --set-selections; done",
	#  onlyif  => "dpkg --get-selections | grep linux-image | grep -q install"
	#}

	file {
		'sources.list.d':
			path     => "${sources_dir}",
			ensure   => directory,
			checksum => md5,
			owner    => root,
			group    => root,
			mode     => 0755;
		"${apt_dir}/sources.list":
			ensure => absent;
	}
}

define aptrepocreatefile($ensure, $url, $distribution, $component = 'main') {
	include apt_defaults
	file { "aptrepo-$name":
		path    => "${apt_defaults::sources_dir}/${name}.list",
		content => "deb $url $distribution $component\n",
		owner   => root,
		group   => root,
		mode    => 0644,
		ensure  => $ensure,
		notify  => Exec['aptitude-update'];
	}
}

define aptrepo_debian($ensure, $component = 'main') {
	aptrepocreatefile { "debian-$name":
		ensure       => $ensure,
		url          => 'http://ftp.fr.debian.org/debian/',
		distribution => "$name",
		component    => "$component"
	}
}

define aptrepo_debian_security($ensure, $component = 'main') {
	aptrepocreatefile { "debian-$name-security":
		ensure       => $ensure,
		url          => 'http://security.debian.org/',
		distribution => "$name/updates",
		component    => "$component"
	}
}

define aptrepo_squeeze_backports($ensure, $component = 'main') {
	aptrepocreatefile { "debian-$name-backports":
		ensure       => $ensure,
		url          => 'http://backports.debian.org/debian-backports',
		distribution => "$name-backports",
		component    => "$component"
	}
}

define aptrepo_deb_multi($ensure, $component = 'main') {
	aptrepocreatefile { "deb_multi-$name":
		ensure       => $ensure,
		url          => 'http://www.deb-multimedia.org',
		distribution => "$name",
		component    => "$component"
	}
}

define aptrepo($squeeze, $wheezy, $jessie, $sid, $experimental, $deb_multi, $component = 'main') {
	aptrepo_debian {
		'squeeze':          ensure => $squeeze,      component => "$component";
		'squeeze-updates':  ensure => $squeeze,      component => "$component";
		'wheezy':           ensure => $wheezy,       component => "$component";
		'wheezy-updates':   ensure => $wheezy,       component => "$component";
		'wheezy-backports': ensure => $wheezy,       component => "$component";
		'jessie':           ensure => $jessie,       component => "$component";
		'sid':              ensure => $sid,          component => "$component";
		'experimental':     ensure => $experimental, component => "$component";
	}
	aptrepo_debian_security {
		'squeeze': ensure => $squeeze, component => "$component";
		'wheezy':  ensure => $wheezy,  component => "$component";
		'jessie':  ensure => $jessie,  component => "$component";
	}
	aptrepo_squeeze_backports {
		'squeeze': ensure => $squeeze, component => "$component";
	}
	if ("$deb_multi" == 'present') {
		aptrepo_deb_multi {
			'squeeze':           ensure => $squeeze,      component => "$component";
			'squeeze-backports': ensure => $squeeze,      component => "$component";
			'wheezy':            ensure => $wheezy,       component => "$component";
			'wheezy-backports':  ensure => absent;
			'jessie':            ensure => $jessie,       component => "$component";
			'sid':               ensure => $sid,          component => "$component";
			'experimental':      ensure => $experimental, component => "$component";
		}
	} else {
		aptrepo_deb_multi {
			'squeeze':           ensure => absent;
			'squeeze-backports': ensure => absent;
			'wheezy':            ensure => absent;
			'wheezy-backports':  ensure => absent;
			'jessie':            ensure => absent;
			'sid':               ensure => absent;
			'experimental':      ensure => absent;
		}
	}
}

define aptpref($current) {
	include apt_defaults
	file { "aptpref-$name":
		path   => "${apt_defaults::apt_dir}/preferences",
		source => "puppet:///modules/sources/preferences_$current",
		owner  => root,
		group  => root,
		mode   => 0644,
		ensure => $ensure,
		notify => Exec['aptitude-update'];
	}
}

define aptproxy() {
	include apt_defaults
	file { "aptproxy":
		path    => "${apt_defaults::apt_conf_dir}/99proxy",
		content => 'Acquire::http::Proxy "http://xen:3142";',
		owner   => root,
		group   => root,
		mode    => 0644,
		ensure  => $ensure,
		notify  => Exec['aptitude-update'];
	}
}

class sources_test {
	aptrepo { "$clientcert":
		squeeze      => present,
		wheezy       => present,
		jessie       => absent,
		sid          => absent,
		experimental => absent,
		deb_multi    => absent;
	}
	aptpref { 'preferences': current => wheezy; }
	aptproxy { 'proxy': }
}

class sources_xen {
	aptrepo { "$clientcert":
		squeeze      => present,
		wheezy       => present,
		jessie       => absent,
		sid          => absent,
		experimental => absent,
		deb_multi    => absent;
	}
	aptpref { 'preferences': current => squeeze; }
}

class sources_ssh {
	aptrepo { "$clientcert":
		squeeze      => present,
		wheezy       => absent,
		jessie       => absent,
		sid          => absent,
		experimental => absent,
		deb_multi    => absent;
	}
	aptpref { 'preferences': current => squeeze; }
	aptproxy { 'proxy': }
}

class sources_pub {
	aptrepo { "$clientcert":
		squeeze      => present,
		wheezy       => present,
		jessie       => absent,
		sid          => absent,
		experimental => absent,
		deb_multi    => absent;
	}
	aptpref { 'preferences': current => squeeze; }
	aptproxy { 'proxy': }
}

class sources_phpmu {
	aptrepo { "$clientcert":
		squeeze      => present,
		wheezy       => present,
		jessie       => absent,
		sid          => absent,
		experimental => absent,
		deb_multi    => absent;
	}
	aptpref { 'preferences': current => squeeze; }
	aptproxy { 'proxy': }
}

class sources_petunia {
	aptrepo { "$clientcert":
		squeeze      => absent,
		wheezy       => absent,
		jessie       => absent,
		sid          => present,
		experimental => absent,
		deb_multi    => absent;
	}
	aptpref { 'preferences': current => sid; }
}


class sources {
	include "sources_$clientcert"
}
