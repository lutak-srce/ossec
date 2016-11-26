class ossec::server (
  String               $package_name,
  String               $package_ensure,
  String               $service_name,
  Boolean              $service_enable,
  String               $service_ensure,
  Optional[String]     $service_provider,
  Stdlib::Absolutepath $agent_conf_file,
  String               $agent_conf_ensure,
  String               $agent_conf_src,
  String               $agent_conf_owner,
  String               $agent_conf_group,
  String               $agent_conf_mode,
  Stdlib::Absolutepath $local_decoder_file,
  String               $local_decoder_src,
  String               $local_decoder_owner,
  String               $local_decoder_group,
  String               $local_decoder_mode,
) inherits ossec {

  package { $ossec::server::package_name:
    ensure => $ossec::server::package_ensure,
  }

  service { $ossec::server::service_name:
    ensure     => $ossec::server::service_ensure,
    enable     => $ossec::server::service_enable,
    name       => $ossec::server::service_name,
    provider   => $ossec::server::service_provider,
    hasstatus  => true,
    hasrestart => true,
    require    => Package[$ossec::server::package_name],
  }

  file { $ossec::server::agent_conf_file:
    ensure  => $ossec::server::agent_conf_ensure,
    source  => $ossec::server::agent_conf_src,
    owner   => $ossec::server::agent_conf_owner,
    group   => $ossec::server::agent_conf_group,
    mode    => $ossec::server::agent_conf_mode,
    require => Package[$ossec::server::package_name],
    notify  => Service[$ossec::server::service_name],
  }

  file { $ossec::server::local_decoder_file:
    ensure  => $ossec::server::local_decoder_ensure,
    source  => $ossec::server::local_decoder_src,
    owner   => $ossec::server::local_decoder_owner,
    group   => $ossec::server::local_decoder_group,
    mode    => $ossec::server::local_decoder_mode,
    require => Package[$ossec::server::package_name],
    notify  => Service[$ossec::server::service_name],
  }

}
