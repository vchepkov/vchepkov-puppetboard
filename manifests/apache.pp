# Puppetboard apache config
define puppetboard::apache (
  String $instance = $title,
  String $alias = "/puppetboad/${instance}",
) {

  require puppetboard::install
  require puppetboard::apache::config

  apache::custom_config { "puppetboard-${instance}":
    filename      => "puppetboard-${instance}.conf",
    content       => epp("${module_name}/instance.conf.epp", {
      instance => $instance,
      alias    => $alias,
    }),
    verify_config => false,
  }
}
