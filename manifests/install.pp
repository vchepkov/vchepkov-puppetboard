# install puppetboard
class puppetboard::install (
  String[1] $revision = '2.1.2',
  String[1] $user  = 'puppetboard',
  String[1] $group = 'puppetboard',
  Stdlib::Unixpath $basedir = '/opt/puppetboard',
) {

  group { 'puppetboard':
    ensure => present,
    name   => $group,
    system => true,
  }

  user { 'puppetboard':
    ensure     => present,
    shell      => '/sbin/nologin',
    home       => $basedir,
    managehome => false,
    gid        => 'puppetboard',
    system     => true,
  }

  file { 'basedir':
    ensure => directory,
    path   => $basedir,
    owner  => 'puppetboard',
    group  => 'puppetboard',
    mode   => '0755',
  }

  $codedir = "${basedir}/code"

  require puppetboard::python

  exec { 'create puppetboard virual environment':
    command => "${puppetboard::python::bin} -m venv --clear ${codedir} && ${codedir}/bin/pip3 install --upgrade pip && ${codedir}/bin/pip3 install --upgrade setuptools",
    creates => "${codedir}/bin/activate",
  }

  package { 'puppetboard':
    ensure   => $revision,
    provider => 'pip3',
    command  => "${codedir}/bin/pip3",
  }
}
