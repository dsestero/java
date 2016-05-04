# = Define: java::config
#
# Configures Java.
# It is intended to be called by java::java.
#
# == Actions:
#
# Sets up the default java according to the parameter
# <tt>java_default_version</tt> if it is not null.
#
# == Requires:
# none
#
define java::config ($java_default_version, $java_version = $title,) {
  if $java_default_version != undef and $java_version == $java_default_version {
    case $::osfamily {
      'Debian' : {
        case $::operatingsystemrelease {
          '10.04' : {
            $javadir = "/usr/lib/jvm/java-${java_version}-openjdk/jre/bin/java"
          }
          '12.04' : {
            $javadir = "/usr/lib/jvm/java-${java_version}-openjdk-${::architecture}/jre/bin/java"
          }
          default : {
            fail("The ${module_name} module is not supported on ${::operatingsystem} release ${::operatingsystemrelease}"
            )
          }
        }
      }
      'RedHat' : {
        case $::operatingsystemmajrelease {
          '6' : {
            $javadir = "/usr/lib/jvm/java-${java_version}-openjdk/jre/bin/java"
          }
          '7' : {
            $javadir = "/usr/lib/jvm/java-${java_version}-openjdk/jre/bin/java"
          }
          default : {
            fail("The ${module_name} module is not supported on ${::operatingsystem} release ${::operatingsystemmajrelease}"
            )
          }
        }
      }
      default  : {
        fail("The ${module_name} module is not supported on an ${::operatingsystem} distribution."
        )
      }
    }

    exec { 'set_java':
      command => "/usr/sbin/update-alternatives --set java ${javadir}",
      unless  => "ls -l /etc/alternatives/java | grep ${javadir}",
    }
  }
}
