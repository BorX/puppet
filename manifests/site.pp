filebucket { main: server => 'puppetmaster' }
File { backup => main }

Exec {
	path => [
		'/usr/local/bin',
		'/opt/local/bin',
		'/usr/bin',
		'/usr/sbin',
		'/bin',
		'/sbin'],
	logoutput => true,
}

node debian {
	case $operatingsystem {
		debian: {
			Package <| |> {
				provider => aptitude,
				ensure   => latest,
			}
		}
		default: {
			err("$clientcert runs $operatingsystem.")
		}
	}
}

class base {
	class{'iptables':}
	-> class{'sources':}
	-> class{'locales':}
	-> class{'exim4':}
	-> class{'keyboard':}
	-> class{'users':}
	-> class{'dotfiles':}
	-> class{'hosts':}
	-> class{'ssh':}
	-> class{'console':}
	-> class{'ntp':}
}

node xen, phpmu, pub, ssh inherits debian {
	class{'base':}
}

node petunia inherits debian {
	class{'base':}
	-> class{'security':}
	-> class{'kde':}
	-> package{'unrar-free':}
}

node test inherits debian {
	class{'base':}
	-> class{'security':}
	-> class{'tests':}
	-> class{'console::plus':}
}

