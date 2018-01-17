# Configures Java.
# It is intended to be called by java::java.
#
# @param java_version [Integer] the java version.
#   Possible values at this time are
#   <tt>6</tt> and <tt>7</tt>.
#
# @param java_default_version [Integer] the java default version.
#   Possible values at this time are
#   <tt>6</tt> and <tt>7</tt>.
#   If different than +undef+ it will be used to configure
#   the alternative system.
#
# == Actions:
#
# Sets up the default java according to the parameter
# <tt>java_default_version</tt> if it is not null.
#
# == Requires:
# none
#
define java::install_config ($java_default_version, $java_version = $title,) {
  case $facts['os']['family'] {
    'Debian' : {
          $javapkg = "openjdk-${java_version}-jdk"
          $javadir = "/usr/lib/jvm/java-${java_version}-openjdk-${facts['os']['architecture']}/jre/bin/java"
          if $facts['os']['release'] in ['12.04', '14.04'] and $java_version == '8' {
            apt::ppa { 'ppa:openjdk-r/ppa': }
          }
    }
    'RedHat' : {
      $javapkg = "java-1.${java_version}.0-openjdk"
      $javadir = "/usr/lib/jvm/jre-1.${java_version}.0-openjdk.${facts['os']['architecture']}/bin/java"
    }
    default  : {
      fail("The ${module_name} module is not supported on an ${facts['os']['family']} distribution.")
    }
  }

  package { $javapkg:
    ensure => installed,
  }

  if $java_default_version != undef and $java_version == $java_default_version {
    exec { 'set_java':
      command => "/usr/sbin/update-alternatives --set java ${javadir}",
      unless  => "ls -l /etc/alternatives/java | grep ${javadir}",
    }
  }
}