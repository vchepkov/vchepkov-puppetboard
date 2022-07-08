# Class to manage python package
class puppetboard::python (
  String $python_module = 'python38',
  Boolean $manage = true,
  Stdlib::Unixpath $bin = '/bin/python3.8',
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
