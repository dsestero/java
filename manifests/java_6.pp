# This class installs Java-6.
#
# @example Declaring in manifest
#   include java::java_6
# @example Hiera data for using java_6
#   classes:
#     - java::java_6
class java::java_6 {

  java {'6': }
}
