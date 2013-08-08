# TODO Symlink .bashrc -> profile
class dotfiles {
	file { '/root/.gitconfig':
		owner   => root,
		group   => root,
		mode    => 600,
		source  => 'puppet:///modules/dotfiles/home/.gitconfig'
 	}
	file { '/root/.toprc':
		owner   => root,
		group   => root,
		mode    => 600,
		source  => 'puppet:///modules/dotfiles/home/.toprc'
 	}
	file { '/root/.htoprc':
		owner   => root,
		group   => root,
		mode    => 600,
		source  => 'puppet:///modules/dotfiles/home/.htoprc'
 	}
	file { '/home/borx/.gitconfig':
		owner   => borx,
		group   => borx,
		mode    => 600,
		source  => 'puppet:///modules/dotfiles/home/.gitconfig'
 	}
	file { '/home/borx/.toprc':
		owner   => borx,
		group   => borx,
		mode    => 600,
		source  => 'puppet:///modules/dotfiles/home/.toprc'
 	}
	file { '/home/borx/.htoprc':
		owner   => borx,
		group   => borx,
		mode    => 600,
		source  => 'puppet:///modules/dotfiles/home/.htoprc'
 	}

	file {'/etc/vim/vimrc.local':
		owner   => root,
		group   => root,
		mode    => 644,
		source  => 'puppet:///modules/dotfiles/vim/vimrc.local'
 	}

	file {'/etc/profile.d/01_history.sh':
		owner   => root,
		group   => root,
		mode    => 644,
		source  => 'puppet:///modules/dotfiles/profile.d/01_history.sh'
 	}

	file {'/etc/profile.d/02_term.sh':
		owner   => root,
		group   => root,
		mode    => 644,
		source  => 'puppet:///modules/dotfiles/profile.d/02_term.sh'
 	}

	file {'/etc/profile.d/11_shellAlias.sh':
		owner   => root,
		group   => root,
		mode    => 644,
		source  => 'puppet:///modules/dotfiles/profile.d/11_shellAlias.sh'
 	}

	file {'/etc/profile.d/12_functions.sh':
		owner   => root,
		group   => root,
		mode    => 644,
		source  => 'puppet:///modules/dotfiles/profile.d/12_functions.sh'
 	}

	file {'/etc/profile.d/21_editors.sh':
		owner   => root,
		group   => root,
		mode    => 644,
		source  => 'puppet:///modules/dotfiles/profile.d/21_editors.sh'
 	}

	file {'/etc/profile.d/31_color.sh':
		owner   => root,
		group   => root,
		mode    => 644,
		source  => 'puppet:///modules/dotfiles/profile.d/31_color.sh'
 	}

	file {'/etc/profile.d/91_networking.sh':
		owner   => root,
		group   => root,
		mode    => 644,
		source  => 'puppet:///modules/dotfiles/profile.d/91_networking.sh'
 	}
}

