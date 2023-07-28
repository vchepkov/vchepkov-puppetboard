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
voxpupuli/puppetboard v5+ requires python v3.8 and above
if you use apache wsgi as a webserver, python variables should be adjusted accordingly
