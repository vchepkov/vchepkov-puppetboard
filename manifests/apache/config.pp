# Basic apache configuration for Puppetboard
class puppetboard::apache::config (
  Boolean $manage_selinux = true,
  Integer $threads = 4,
  Integer $maxreqs = 0,
) {

  require puppetboard::install
  include apache::mod::wsgi

  Class['puppetboard::install'] ~> Class['apache::service']

  apache::custom_config { 'puppetboard':
    filename      => 'puppetboard.conf',
    content       => epp("${module_name}/puppetboard.conf", {
      docroot => $puppetboard::install::basedir,
      user    => $puppetboard::install::user,
      group   => $puppetboard::install::group,
      threads => $threads,
      maxreqs => $maxreqs,
    }),
    verify_config => false,
  }

  if fact('os.selinux.enabled') {
    apache::custom_config { 'wsgi disable python bytecode':
      filename      => 'wsgi-custom.conf',
      content       => file("${module_name}/wsgi.conf"),
      verify_config => false,
    }
  }

  if $manage_selinux {
    selboolean { 'httpd_can_network_connect' :
      persistent => true,
      value      => 'on',
      before     => Class['apache::service'],
    }
  }
}
