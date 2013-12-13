class users {
	package {'sudo':}
	-> group {'borx':
		ensure => present,
		gid    => '1000',
	}
	-> user {'borx':
		require    => [ Package['sudo'], Group['borx'] ],
		ensure     => present,
		uid        => '1000',
		gid        => 'borx',
		groups     => 'sudo',
		shell      => '/bin/bash',
		home       => '/home/borx',
		managehome => true,
	}
	-> file {'/home/borx/.ssh/':
		ensure  => directory,
		owner   => borx,
		group   => borx,
		mode    => 600,
		source  => [ "puppet:///modules/users/$clientcert" ],
		sourceselect => all,
		recurse => true,
	}
	-> file { '/home/borx/.gitconfig':
		owner   => borx,
		group   => borx,
		mode    => 600,
		source  => 'puppet:///modules/users/dotfiles/home/.gitconfig'
 	}
	-> file { '/home/borx/.toprc':
		owner   => borx,
		group   => borx,
		mode    => 600,
		source  => 'puppet:///modules/users/dotfiles/home/.toprc'
 	}
	-> file { '/home/borx/.htoprc':
		owner   => borx,
		group   => borx,
		mode    => 600,
		source  => 'puppet:///modules/users/dotfiles/home/.htoprc'
 	}

	file { '/root/.gitconfig':
		owner   => root,
		group   => root,
		mode    => 600,
		source  => 'puppet:///modules/users/dotfiles/home/.gitconfig'
 	}
	file { '/root/.toprc':
		owner   => root,
		group   => root,
		mode    => 600,
		source  => 'puppet:///modules/users/dotfiles/home/.toprc'
 	}
	file { '/root/.htoprc':
		owner   => root,
		group   => root,
		mode    => 600,
		source  => 'puppet:///modules/users/dotfiles/home/.htoprc'
 	}

	file {'/etc/vim/vimrc.local':
		owner   => root,
		group   => root,
		mode    => 644,
		source  => 'puppet:///modules/users/dotfiles/vim/vimrc.local'
 	}

	file {'/etc/profile.d/01_history.sh':
		owner   => root,
		group   => root,
		mode    => 644,
		source  => 'puppet:///modules/users/dotfiles/profile.d/01_history.sh'
 	}

	file {'/etc/profile.d/02_term.sh':
		owner   => root,
		group   => root,
		mode    => 644,
		source  => 'puppet:///modules/users/dotfiles/profile.d/02_term.sh'
 	}

	file {'/etc/profile.d/11_shellAlias.sh':
		owner   => root,
		group   => root,
		mode    => 644,
		source  => 'puppet:///modules/users/dotfiles/profile.d/11_shellAlias.sh'
 	}

	file {'/etc/profile.d/12_functions.sh':
		owner   => root,
		group   => root,
		mode    => 644,
		source  => 'puppet:///modules/users/dotfiles/profile.d/12_functions.sh'
 	}

	file {'/etc/profile.d/21_editors.sh':
		owner   => root,
		group   => root,
		mode    => 644,
		source  => 'puppet:///modules/users/dotfiles/profile.d/21_editors.sh'
 	}

	file {'/etc/profile.d/31_color.sh':
		owner   => root,
		group   => root,
		mode    => 644,
		source  => 'puppet:///modules/users/dotfiles/profile.d/31_color.sh'
 	}

	file {'/etc/profile.d/91_networking.sh':
		owner   => root,
		group   => root,
		mode    => 644,
		source  => 'puppet:///modules/users/dotfiles/profile.d/91_networking.sh'
 	}
}
