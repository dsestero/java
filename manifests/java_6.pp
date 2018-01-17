# This class installs Java-6.
#
# Actions:
#
# Installs Java-6 by declaring the +java+ define.
#
# Requires: see Modulefile
#
# Sample Usage:
#
#  include java::java_6
class java::java_6 {

  java {'6': }
}
