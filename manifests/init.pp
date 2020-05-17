# puppetboard instance
define puppetboard (
  String $instance = $title,
  String $host = 'localhost',
  Integer $port = 8080,
  String $default_environment = 'production',
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
      host                => $host,
      port                => $port,
      default_environment => $default_environment,
      config              => $config,
    }),
  }

  file { "${puppetboard::install::basedir}/${instance}/wsgi.py":
    ensure  => file,
    owner   => 'puppetboard',
    group   => 'puppetboard',
    mode    => '0644',
    content => epp("${module_name}/wsgi.py.epp", {
      basedir => "${puppetboard::install::basedir}/${instance}",
    }),
  }
}
