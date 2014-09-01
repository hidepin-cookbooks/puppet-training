user { 'kentaro':
	ensure => present,
	comment => 'kentaro',
	home => '/home/kentaro',
	managehome => true,
	shell => '/bin/bash',
}

group { 'developers':
	ensure => present,
	gid => 1999,
}

user { 'antipop':
	ensure => present,
	gid => 'guest',
	comment => 'antipop',
	home => '/home/antipop',
	managehome => true,
	shell => '/bin/bash',
}

group { 'guest':
	ensure => present,
	gid => 2000,
}
