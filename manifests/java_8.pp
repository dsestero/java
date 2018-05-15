# This class installs Java-8.
#
# @example Declaring in manifest
#   include java::java_8
# @example Hiera data for using java_8
#   classes:
#     - java::java_8
class java::java_8 {

  java {8: }
}
