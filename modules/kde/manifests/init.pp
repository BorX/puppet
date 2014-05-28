class kde {
	package{[
		'kde-full',
		'kde-standard',
		'kde-l10n-fr'
	]:}
	-> package{'iceweasel-l10n-fr':} -> package{'flashplugin-nonfree':}
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
