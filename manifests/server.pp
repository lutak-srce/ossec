# Class: ossec::server
#
# This module manages ossec server
#
# Requires:
#
#

# Sample Usage:
#   include ossec::server
#
class ossec::server inherits ossec {
  package { 'ossec-hids-server':
    ensure   => present,
  }
  service { 'ossec-hids':
    ensure   => running,
    enable   => true,
    provider => redhat,
    require  => Package['ossec-hids-server'],
  }
  file { '/var/ossec/etc/local_decoder.xml':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => 'puppet:///modules/ossec/local_decoder.xml',
    require => Package['ossec-hids-server'],
    notify  => Service['ossec-hids'],
  }
}
