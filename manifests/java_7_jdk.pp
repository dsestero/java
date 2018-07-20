# This class installs Oracle Java-7.
#
# @example Declaring in manifest
#   include java::java_7_jdk
# @example Hiera data for using java_7_jdk
#   classes:
#     - java::java_7_jdk
class java::java_7_jdk {

  java {'7':
    openjdk => false;
  }
}
