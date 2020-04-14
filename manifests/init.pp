# puppetboard instance
define puppetboard (
  String $instance = $title,
  Hash $config = {},
) {

  require puppetboard::install

  file { "${puppetboard::install::basedir}/${instance}":
    ensure => directory,
    owner  => 'puppetboard',
    group  => 'puppetboard',
    mode   => '0755',
  }

  file { "${puppetboard::install::basedir}/${instance}/settings.py":
    ensure  => file,
    owner   => 'puppetboard',
    group   => 'puppetboard',
    mode    => '0644',
    content => epp("${module_name}/settings.py.epp", {
      config => $config,
    }),
  }

  file { "${puppetboard::install::basedir}/${instance}/wsgi.py":
    ensure  => file,
    owner   => 'puppetboard',
    group   => 'puppetboard',
    mode    => '0644',
    content => epp("${module_name}/wsgi.py.epp", {
      basedir => "${puppetboard::install::basedir}/${instance}",
      codedir => $puppetboard::install::basedir,
    }),
  }
}
