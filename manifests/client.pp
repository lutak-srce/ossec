class ossec::client (
  String               $server_ip,
  String               $client_name,
  Optional[String]     $client_id,
  Optional[String]     $client_ip,
  Optional[String]     $client_key,
  String               $package_name,
  String               $package_ensure,
  String               $service_name,
  Boolean              $service_enable,
  String               $service_ensure,
  Optional[String]     $service_provider,
  Stdlib::Absolutepath $ossec_conf_file,
  String               $ossec_conf_ensure,
  String               $ossec_conf_epp,
  String               $ossec_conf_owner,
  String               $ossec_conf_group,
  String               $ossec_conf_mode,
  Stdlib::Absolutepath $client_keys_file,
  String               $client_keys_ensure,
  String               $client_keys_epp,
  String               $client_keys_owner,
  String               $client_keys_group,
  String               $client_keys_mode,
  Stdlib::Absolutepath $archives_dir,
  String               $archives_dir_ensure,
  String               $archives_dir_owner,
  String               $archives_dir_group,
  String               $archives_dir_mode,
) {

  package { $ossec::client::package_name:
    ensure => $ossec::client::package_ensure,
  }

  service { $ossec::client::service_name:
    ensure     => $ossec::client::service_ensure,
    enable     => $ossec::client::service_enable,
    name       => $ossec::client::service_name,
    provider   => $ossec::client::service_provider,
    hasstatus  => true,
    hasrestart => true,
    require    => Package[$ossec::client::package_name],
  }

  file { $ossec::client::ossec_conf_file:
    ensure  => $ossec::client::ossec_conf_ensure,
    content => epp($ossec::client::ossec_conf_epp),
    owner   => $ossec::client::ossec_conf_owner,
    group   => $ossec::client::ossec_conf_group,
    mode    => $ossec::client::ossec_conf_mode,
    require => Package[$ossec::client::package_name],
    notify  => Service[$ossec::client::service_name],
  }

  file { $ossec::client::client_keys_file:
    ensure  => $ossec::client::client_keys_ensure,
    content => epp($ossec::client::client_keys_epp),
    owner   => $ossec::client::client_keys_owner,
    group   => $ossec::client::client_keys_group,
    mode    => $ossec::client::client_keys_mode,
    require => Package[$ossec::client::package_name],
    notify  => Service[$ossec::client::service_name],
  }

  file { $ossec::client::archives_dir:
    ensure => $ossec::client::archives_dir_ensure,
    owner  => $ossec::client::archives_dir_owner,
    group  => $ossec::client::archives_dir_group,
    mode   => $ossec::client::archives_dir_mode,
  }
}
