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

  File {
    ensure  => file,
    ensure  => file,
    require => Package['ossec-hids-server'],
    notify  => Service['ossec-hids'],
  }

  file { '/var/ossec/etc/local_decoder.xml':
    owner  => root,
    group  => root,
    mode   => '0644',
    source => 'puppet:///modules/ossec/local_decoder.xml',
  }
  file { '/var/ossec/etc/shared/agent.conf':
    owner  => ossec,
    group  => ossec,
    mode   => '0640',
    source => 'puppet:///modules/ossec/agent.conf',
  }
}
