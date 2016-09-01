class dhcp::server(
  $authoritative       = $::dhcp::server::params::authoritative,
  $log_facility        = $::dhcp::server::params::log_facility,
  $ddns_update_style   = $::dhcp::server::params::ddns_update_style,
  $ddns_updates        = $::dhcp::server::params::ddns_updates,
  $domain_name         = $::dhcp::server::params::domain_name,
  $domain_name_servers = $::dhcp::server::params::domain_name_servers,
  $next_server         = $::dhcp::server::params::next_server,
  $default_lease_time  = $::dhcp::server::params::default_lease_time,
  $min_lease_time      = $::dhcp::server::params::min_lease_time,
  $max_lease_time      = $::dhcp::server::params::max_lease_time,
  $omapi_port          = $::dhcp::server::params::omapi_port,
) inherits dhcp::server::params {
  class {'::dhcp::server::install': } ->
  class {'::dhcp::server::config':  } ~>
  class {'::dhcp::server::service': }
}