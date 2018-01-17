# This class installs Java-7.
#
# Actions:
#
# Installs Java-7 by declaring the +java+ define.
#
# Requires: see Modulefile
#
# Sample Usage:
#
#  include java::java_7
class java::java_7 {

  java {'7': }
}
