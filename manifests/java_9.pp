# This class installs Java-9.
#
# @example Declaring in manifest
#   include java::java_9
# @example Hiera data for using java_9
#   classes:
#     - java::java_9
class java::java_9 {

  java {'9': }
}
