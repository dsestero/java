# Creates /opt/jdk folder used to contain Oracle jdk installation.
class java::jdkfolder {
  file {'/opt/jdk':
    ensure => directory,
  }
}