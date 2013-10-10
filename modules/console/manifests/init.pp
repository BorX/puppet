class console {
	package{[ 'git', 'mutt', 'bash-completion', 'lsof', 'less', 'most', 'foremost', 'file', 'vim', 'colordiff', 'pv', 'ccze', 'lwatch', 'fdupes', 'sysstat', 'time', 'iftop', 'atop', 'iotop', 'htop', 'rsync', 'whois', 'deborphan', 'p7zip-full', 'unzip', 'zip', 'byobu', 'apt-show-versions' ]:}
}

class console::plus {
	package{[
		'bc',
		'dc',
		'at',
		'nmap',
		'ftp',
		'telnet',
		'w3m',
		'pm-utils',
		'hdparm',
		'make',
		'strace'
	]:}
}
