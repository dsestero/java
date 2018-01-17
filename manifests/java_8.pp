# This class installs Java-8.
#
# Actions:
#
# Installs Java-8 by declaring the +java+ define.
#
# Requires: see Modulefile
#
# Sample Usage:
#
#  include java::java_8
class java::java_8 {

  java {'8': }
}
