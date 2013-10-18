class gnome {
	package{'gnome':}
	-> package{'fusion-icon':} -> package{'compiz-fusion-plugins-main':} -> package{'compiz-fusion-plugins-extra':} -> package{'compizconfig-settings-manager':}
	-> file { '/etc/compizconfig/start-compiz.sh':
		owner  => root,
		group  => root,
		mode   => 755,
		source => 'puppet:///modules/gnome/start-compiz.sh'
	}
	-> file { '/etc/compizconfig/compiz.desktop':
		owner  => root,
		group  => root,
		mode   => 644,
		source => 'puppet:///modules/gnome/compiz.desktop'
	}
	-> file { '/usr/share/xsessions/compiz.desktop':
		ensure => 'link',
		target => '/etc/compizconfig/compiz.desktop',
	}
	-> file { '/etc/gdm3/daemon.conf':
		owner  => root,
		group  => root,
		mode   => 644,
		source => 'puppet:///modules/gnome/daemon.conf'
	}
	-> package{'cairo-dock':}
	-> package{'iceweasel-l10n-fr':} -> package{'flashplugin-nonfree':}
	-> package{[
		'vlc',
		'terminator',
		'filezilla',
		'hunspell-fr'
	]:}
}
