# Puppetboard apache config
define puppetboard::apache (
  String $instance = $title,
  String $url_path = "/puppetboad/${instance}",
) {
  require puppetboard::install
  require puppetboard::apache::config

  apache::custom_config { "puppetboard-${instance}":
    filename      => "puppetboard-${instance}.conf",
    content       => epp("${module_name}/instance.conf.epp", {
        instance => $instance,
        url_path => $url_path,
    }),
    verify_config => false,
  }
}
