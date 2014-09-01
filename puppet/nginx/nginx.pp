yumrepo { 'nginx':
	descr	=> 'nginx yum repository',
	baseurl	=> 'http://nginx.org/packages/centos/7/$basearch/',
	enabled	=> 1,
	gpgcheck => 0,
}

package { 'nginx':
	ensure	=> installed,
	require	=> Yumrepo['nginx'],
        allow_virtual => true,
}

$port = 80

file { '/etc/nginx/conf.d/my.conf':
	ensure	=> present,
	owner	=> 'root',
	group	=> 'root',
	mode	=> '0644',
	content	=> template('my.conf'),
	require	=> Package['nginx'],
	notify	=> Service['nginx'],
}

$target = 'Puppet'

file { '/usr/share/nginx/html/index.html':
	ensure	=> present,
	owner	=> 'root',
	group	=> 'root',
	mode	=> '0644',
	content	=> template('index.html'),
	require	=> Package['nginx'],
}

service { 'nginx':
	enable	=> true,
	ensure	=> running,
	hasrestart => true,
	require	=> File['/etc/nginx/conf.d/my.conf'],
}

package { 'epel-release':
	ensure	=> installed,
	provider => rpm,
	source	=> "http://ftp.iij.ad.jp/pub/linux/fedora/epel//7/x86_64/e/epel-release-7-1.noarch.rpm",
	allow_virtual => true,
}

file { '/etc/nginx/site-available':
	ensure => directory,
	owner => 'root',
	group => 'root',
	mode => '0755',
}

file { '/etc/nginx/site-enabled':
	ensure => directory,
	owner => 'root',
	group => 'root',
	mode => '0755',
}

file { '/etc/nginx/site-available/mysite.conf':
	ensure => present,
	owner => 'root',
	group => 'root',
	mode => '0644',
	require => File['/etc/nginx/site-available'],
}

file { '/etc/nginx/site-enabled/mysite.conf':
	ensure => link,
	target => '/etc/nginx/site-available/mysite.conf',
	owner => 'root',
	group => 'root',
	mode => '0644',
	require => File['/etc/nginx/site-available/mysite.conf'],
}

