define reprepro::repository($basedir = "/var/www/${name}", $config, $owner='root', $group='root')
{
  $dirs = [ "${basedir}/conf", "${basedir}/dists", "${basedir}/incoming", "${basedir}/indices", "${basedir}/logs", "${basedir}/pool", "${basedir}/project", "${basedir}/tmp"]
  file {
    "${basedir}":
      owner    => $owner,
      group    => $group,
      ensure   => directory;
    $dirs:
      owner    => $owner,
      group    => $group,
      ensure   => directory;
    "${basedir}/conf/distributions":
      owner    => root,
      group    => root,
      ensure   => present,
      content  => template($config);
    "${basedir}/conf/incoming":
      owner    => $owner,
      group    => $group,
      ensure   => present,
      content  => template('reprepro/incoming.erb');
  }  

  exec {
    "${name}/processincoming":
      path    => '/bin:/usr/bin',
      command => "reprepro -V -b ${basedir}  processincoming default",
      onlyif  => "ls ${basedir}/incoming/*changes";
  }
}
