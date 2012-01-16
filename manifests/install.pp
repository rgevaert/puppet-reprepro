class reprepro::install
{
  package {
    'reprepro':
      ensure => installed
  }

  if !defined(Package["gnupg"])
  {
    package {
      'gnupg':
        ensure => installed
    }
  }
}
