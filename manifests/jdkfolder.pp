class jdkfolder {
  file {'/opt/jdk':
    ensure => directory,
  }
}