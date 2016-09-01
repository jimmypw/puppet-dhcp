class dhcp::server::config(
  $authoritative       = $::dhcp::server::authoritative,
  $log_facility        = $::dhcp::server::log_facility,
  $ddns_updates        = $::dhcp::server::ddns_updates,
  $ddns_update_style   = $::dhcp::server::ddns_update_style,
  $next_server         = $::dhcp::server::next_server,
  $domain_name         = $::dhcp::server::domain_name,
  $domain_name_servers = $::dhcp::server::domain_name_servers,
  $default_lease_time  = $::dhcp::server::default_lease_time,
  $min_lease_time      = $::dhcp::server::min_lease_time,
  $max_lease_time      = $::dhcp::server::max_lease_time,
  $omapi_port          = $::dhcp::server::omapi_port,
  $dhcp_config         = $::dhcp::server::params::dhcpd_config
)
{
  concat{$dhcp_config :
    ensure => present
  }

  concat::fragment{ 'main' :
    target  => $dhcp_config,
    content => template('dhcp/dhcpd.conf.main.erb'),
    order   => 01,
  }
}