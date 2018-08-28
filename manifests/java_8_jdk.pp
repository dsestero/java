# This class installs Oracle Java-8.
#
# @example Declaring in manifest
#   include java::java_8_jdk
# @example Hiera data for using java_8_jdk
#   classes:
#     - java::java_8_jdk
class java::java_8_jdk {

  java { '8':
    openjdk => false;
  }
}
