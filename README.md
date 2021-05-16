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

### To use python 3.8 the following attributes can be used
```
apache::mod::wsgi::mod_path: 'modules/mod_wsgi_python3.so'
apache::mod::wsgi::package_name: 'python38-mod_wsgi'

puppetboard::python::bin: '/bin/python3.8'
puppetboard::python::python_module: 'python38'

```
