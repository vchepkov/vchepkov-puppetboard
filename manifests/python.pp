# Class to manage python package
class puppetboard::python (
  Stdlib::Unixpath $bin,
  String $pip_package,
  Optional[String] $python_module = undef,
  Boolean $manage = true,
) {
  if $manage {
    if $python_module {
      package { 'python module':
        ensure      => installed,
        name        => $python_module,
        enable_only => true,
        provider    => 'dnfmodule',
        before      => Package['pip'],
      }
    }
    package { 'pip':
      ensure => installed,
      name   => $pip_package,
    }
  }
}
