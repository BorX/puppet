class locales {
	package {'locales':} ~> exec {'dpkg-reconfigure locales': refreshonly => true}
}
