class security {
	require exim4

	package{'tripwire':} -> package{'lire':} -> package{[ 'chkrootkit', 'rkhunter', 'fail2ban', 'checksecurity', 'logcheck' ]:}
}
