# vchepkov-puppetboard
Install puppetboard
## Usage

```
  class { 'apache':
    server_tokens    => 'Prod',
    server_signature => 'Off',
    trace_enable     => 'Off',
    mpm_module       => 'event',
  }

  file { '/var/www/html/index.html':
    ensure  => file,
    owner   => root,
    group   => root,
    content => '<html><head><meta http-equiv="refresh" content="0;/puppetboard"></head></html>',
    require => Class['apache'],
  }

  puppetboard { 'local':
    default_environment => '*',
    config              => {
      'DAILY_REPORTS_CHART_DAYS' => '10',
      'ENABLE_CATALOG'           => 'True',
    }
  }

  puppetboard::apache { 'local':
    url_path => '/puppetboard',
  }
```

## Python requirements
voxpupuli/puppetboard v4+ requires python v3.7 and above
if you use apache wsgi as a webserver, python variables should be adjusted accordingly
Module uses the following defaults:
```
puppetboard::apache::config::wsgi_mod_path: modules/mod_wsgi_python3.so
puppetboard::apache::config::wsgi_package_name: python38-mod_wsgi

puppetboard::python::python_module: python38
puppetboard::python::bin: /bin/python3.8
```
