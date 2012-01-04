define reprepro::repository($basedir = "/var/www/${name}", $config)
{
  $dirs = [ "${basedir}/conf", "${basedir}/dists", "${basedir}/incoming", "${basedir}/indices", "${basedir}/logs", "${basedir}/pool", "${basedir}/project", "${basedir}/tmp"]
  file {
    "${basedir}":
      ensure   => directory;
    $dirs:
      ensure   => directory;
    "${basedir}/conf/distributions":
      ensure   => present,
      content  => template($config);
    "${basedir}/conf/incoming":
      ensure   => present,
      content  => template('reprepro/incoming.erb');
  }  

  exec {
    'processincoming':
      path    => '/bin:/usr/bin',
      command => "reprepro -V -b ${basedir}  processincoming default",
      onlyif  => "ls ${basedir}/incoming/*changes";
  }
}
