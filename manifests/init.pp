# This module manages Java.
#
# Declares all other defines in the java module needed for installing Java.
# Currently, these consists of java::install, and java::config.
# If hiera defines a value for the parameter <tt>java_default_version</tt> on
# the target node the command <tt>update-alternatives</tt> is issued to set the
# default java accordingly.
#
# @param java_version [String] the java version.
#   Possible values at this time are
#   <tt>6</tt> and <tt>7</tt>.
#
# @param java_default_version [Optional[String]] the java default version.
#   Possible values at this time are
#   <tt>6</tt> and <tt>7</tt>.
#   If different than +undef+ it will be used to configure
#   the alternative system.
#
# @example Declaring in manifest
#   java {6: }
#
# @author Dario Sestero
define java (
  String $java_version                   = $title,
  Optional[String] $java_default_version = lookup('java::java_default_version', Optional[String], 'first', undef)) {

  if $facts['os']['family'] == 'Debian' {
    include apt
  }
  java::install_config { $java_version:
    java_default_version => $java_default_version,
  }
}
