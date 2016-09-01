define dhcp::server::host (
  $mac         = undef,
  $address     = undef,
  $dhcp_config = $::dhcp::server::dhcpd_config
)
{

  if ! defined(Class[::dhcp::server]) {
    fail('You must define the dhcp::server class')
  }

  if ! $mac.is_mac_address {
    fail('Mac Address invalid')
  }

  if ! $address.is_ip_address {
    fail('Address does not look like an ip address')
  }

  concat::fragment{"host_${name}":
    target  => $dhcp_config,
    content => template('dhcp/host.erb'),
    order   => 30,
  }
}