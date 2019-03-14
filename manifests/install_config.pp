# Configures Java.
# It is intended to be called by java::java.
#
# @param java_version [String] the java version.
#   Possible values at this time are
#   <tt>6</tt> and <tt>7</tt>.
#
# @param openjdk [Boolean] use openjdk.
#   <tt>true</tt> means to install openjdk from distribution packages
#   <tt>false</tt> means to untar the Oracle archive.
#
# @param java_default_version [Optional[String]] the java default version.
#   Possible values at this time are
#   <tt>6</tt>, <tt>7>/tt> and <tt>8</tt>.
#   Oracle jdk-6, howewer, is not supported while Oracle jdk-7 and Oracle jdk-8 at the moment are 64 bit versions.
#   If different than +undef+ it will be used to configure
#   the alternative system.
#
# == Actions:
#
# Sets up the default java according to the parameter
# <tt>java_default_version</tt> if it is not null.
#
define java::install_config (
  Boolean $openjdk,
  String $java_version = $title,
  Optional[String] $java_default_version,
) {
  case $facts['os']['family'] {
    'Debian' : {
      $javapkg = "openjdk-${java_version}-jdk"
      if $facts['os']['release'] in ['12.04', '14.04'] and $java_version == '8' {
        $javapkg = "openjdk-${java_version}"
        apt::ppa { 'ppa:openjdk-r/ppa': }
      }
    }
    'RedHat' : {
      $javapkg = "java-1.${java_version}.0-openjdk"
    }
    default  : {
      fail("The ${module_name} module is not supported on an ${facts['os']['family']} distribution.")
    }
  }

  include java::jdkfolder

  if $openjdk {
    package { $javapkg:
      ensure => installed,
    }
    case $facts['os']['family'] {
      'Debian' : {
        $javadir = "/usr/lib/jvm/java-${java_version}-openjdk-${facts['os']['architecture']}/jre"
      }
      'RedHat' : {
        if $facts['os']['release']['major'] in ['5', '6'] {
          $javadir = "/usr/lib/jvm/jre-1.${java_version}.0-openjdk.${facts['os']['architecture']}"
        } else {
          $javadir = "/usr/lib/jvm/jre-1.${java_version}.0-openjdk"
        }
      }
      default  : {
        fail("The ${module_name} module is not supported on an ${facts['os']['family']} distribution.")
      }
    }
  } else {
      case $java_version {
        '7' : {
          $distribution_name = 'jdk-7u80-linux-x64.tar.gz'
          $javadir = '/opt/jdk/jdk1.7.0_80'
        }
        '8' : {
          $distribution_name = 'jdk-8u172-linux-x64.tar.gz'
          $javadir = '/opt/jdk/jdk1.8.0_172'
        }
        default  : {
          fail("The ${module_name} module is not supported for Oracle JDK version ${java_version}.")
        }
      }
      download_uncompress {"dwnl_inst_${java_version}":
        distribution_name => "java/${distribution_name}",
        dest_folder       => '/opt/jdk',
        creates           => $javadir,
        uncompress        => 'tar.gz',
      }
      exec { "install_java_${java_version}":
        command => "/usr/sbin/update-alternatives --install /usr/bin/java java ${javadir}/bin/java 100",
        unless  => "/usr/sbin/update-alternatives --display java | grep ${javadir}/bin/java",
      }
  }

  file { "/opt/jdk/java-${java_version}":
    ensure => link,
    target => $javadir,
  }

  if $java_default_version != undef and $java_version == $java_default_version {
    exec { 'set_java':
      command => "/usr/sbin/update-alternatives --set java ${javadir}/bin/java",
      unless  => "ls -l /etc/alternatives/java | grep ${javadir}/bin/java",
    }
  }
}