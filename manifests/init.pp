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
#   <tt>6</tt>, <tt>7</tt>, <tt>8</tt> and <tt>9</tt>.
#
# @param openjdk [Boolean] use openjdk. Defaults to <tt>true</tt>.
#   <tt>true</tt> means to install openjdk from distribution packages
#   <tt>false</tt> means to untar the Oracle archive.
#
# @param java_default_version [Optional[String]] the java default version.
#   Possible values at this time are
#   <tt>6</tt>, <tt>7</tt>, <tt>8</tt> and <tt>9</tt>.
#   If different than +undef+ it will be used to configure
#   the alternative system.
#
# @example Declaring in manifest
#   java {'8': }
#
# @author Dario Sestero
define java (
  String $java_version                   = $title,
  Boolean $openjdk                       = true,
  Optional[String] $java_default_version = lookup('java::java_default_version', Optional[String], 'first', undef)) {

  if $facts['os']['family'] == 'Debian' and $openjdk {
    include apt
  }
  java::install_config { $java_version:
    openjdk              => $openjdk,
    java_default_version => $java_default_version,
  }
}
