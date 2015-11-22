# Class: ossec::client
#
# This module manages ossec client
#
# Requires:
#
#

# Sample Usage:
#   include ossec::client
#
class ossec::client (
  $package_name    = $ossec::client_package_name,
  $service_name    = $ossec::client_service_name,
  $ossec_conf      = $ossec::client_ossec_conf,
  $ossec_conf_tmpl = $ossec::client_ossec_conf_tmpl,
) inherits ossec {
  package { $package_name :
    ensure   => present,
  }
  service { $service_name :
    ensure   => running,
    enable   => true,
    require  => Package[$package_name],
  }
  file { $ossec_conf :
    ensure  => present,
    content => template($ossec_conf_tmpl),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package[$package_name],
    notify  => Service[$service_name],
  }
  file { '/var/ossec/etc/client.keys':
    ensure  => present,
    content => template('ossec/client_keys.erb'),
    owner   => 'ossec',
    group   => 'ossec',
    mode    => '0400',
    require => Package[$package_name],
    notify  => Service[$service_name],
  }
}

