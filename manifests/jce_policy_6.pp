# This class overrides two libraries in the standard java distribution.
# Due to import control restrictions, the version of JCE policy files that
# are bundled in the JDK(TM) 6 environment allow "strong" but limited
# cryptography to be used. This override provides "unlimited strength"
# policy files which contain no restrictions on cryptographic strengths.
# WARNING: At the moment this class supports only openjdk-6 on Debian/Ubuntu systems.

class java::jce_policy_6 {
  file {
    default:
      ensure => present,
      ;
    '/usr/lib/jvm/java-6-openjdk-amd64/jre/lib/security/local_policy.jar':
      source => 'http://jee.invallee.it/dist/java/6/crypto/local_policy.jar',
      ;
    '/usr/lib/jvm/java-6-openjdk-amd64/jre/lib/security/US_export_policy.jar':
      source => 'http://jee.invallee.it/dist/java/6/crypto/US_export_policy.jar',
      ;
  }
}