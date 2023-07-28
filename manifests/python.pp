# Class to manage python package
class puppetboard::python (
  String $python_module,
  Stdlib::Unixpath $bin,
  Boolean $manage = true,
) {
  if $manage {
    package { 'python module':
      ensure   => installed,
      name     => $python_module,
      flavor   => 'common',
      provider => 'dnfmodule',
    }
  }
}
