# Class: ossec::params
#
#   The ossec configuration settings.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class ossec::params {
  $package_ensure   = 'present'
  $server_ip        = '127.0.0.1'
  $client_id        = '1'
  $client_key       = 'nokey_usehiera'
  $client_ip        = 'nokey_usehiera'
  $client_name      = $::fqdn

  case $::osfamily {
    /(RedHat|redhat)/: {
      $client_package_name    = 'ossec-hids-client'
      $client_service_name    = 'ossec-hids'
      $client_ossec_conf      = '/var/ossec/etc/ossec-agent.conf'
      $client_ossec_conf_tmpl = 'ossec/ossec-agent.erb'
    }
    /(Debian|debian|Ubuntu|ubuntu)/: {
      $client_package_name    = 'ossec-agent'
      $client_service_name    = 'ossec-agent'
      $client_ossec_conf      = '/var/ossec/etc/ossec.conf'
      $client_ossec_conf_tmpl = 'ossec/ossec.erb'
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem: ${::operatingsystem}, module ${module_name} currently only supports osfamily RedHat and Debian")
    }
  }
}
