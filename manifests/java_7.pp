# This class installs Java-7.
#
# @example Declaring in manifest
#   include java::java_7
# @example Hiera data for using java_7
#   classes:
#     - java::java_7
class java::java_7 {

  java {'7': }
}
