class kde {
	package{'iceweasel-l10n-fr':} -> package{'flashplugin-nonfree':}
	-> package{[
		'vlc',
		'terminator',
		'filezilla',
		'hunspell-fr'
	]:}
	-> file { '/home/borx/.config/terminator/config':
		owner  => borx,
		group  => borx,
		mode   => 600,
		source => 'puppet:///modules/kde/terminator_config'
	}
}
