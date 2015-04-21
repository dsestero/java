# = Define: java::install
#
# Installs Java.
# It is intended to be called by java::java.
#
# == Actions:
#
# Installs the Java package.
#
# == Requires:
# none
#
define java::install ($java_version = $title) {
  $package_name = $java_version ? {
    6       => 'openjdk-6-jdk',
    7       => 'openjdk-7-jdk',
    default => undef,
  }

  package { $package_name:
    ensure => installed,
  }
}