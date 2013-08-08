class tests {
	file { '/tmp/testCopy.txt':
		owner  => root,
		group  => root,
		mode   => 644,
		source => 'puppet:///modules/tests/test.txt'
	}

	file { '/tmp/testContenu':
		mode    => 644,
		owner   => root,
		group   => root,
		content => 'Le contenu du fichier
avec un retour à la ligne
et encore des trucs...
'
	}
}

class messagesToServer {
	debug   'DEBUG  : Un message au serveur'
	info    'INFO   : Un message au serveur'
	notice  'NOTICE : Un message au serveur'
	warning 'WARNING: Un message au serveur'
	alert   'ALERT  : Un message au serveur'
	err     'ERR    : Un message au serveur'
	emerg   'EMERG  : Un message au serveur'
	crit    'CRITIC : Un message au serveur'
}

class messagesToAgent {
	notify { 'b': message => "BBB" }
	notify { 'a': message => "AAA" }
	Notify['a'] <- Notify['b']

	notify { 'DEBUG  : Un message au client': loglevel => debug }
	notify { 'INFO   : Un message au client': loglevel => info }
	notify { 'NOTICE : Un message au client': loglevel => notice }
	notify { 'WARNING: Un message au client': loglevel => warning }
	notify { 'ALERT  : Un message au client': loglevel => alert }
	notify { 'ERR    : Un message au client': loglevel => err }
	notify { 'EMERG  : Un message au client': loglevel => emerg }
	notify { 'CRIT   : Un message au client': loglevel => crit }
	notify { 'VERBOSE: Un message au client': loglevel => verbose }

	notify { 'Mac warning': message => $operatingsystem ? {
			'Darwin' => 'This seems to be a Mac.',
			default  => "And I’m a PC.",
		},
	}

	exec { 'echo pouette pouette': loglevel => alert }
}
