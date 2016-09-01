define dhcp::server::zone (
  $primary     = undef,
  $key         = undef,
  $dhcp_config = $::dhcp::server::dhcpd_config,
)
{

  if ! defined(Class[::dhcp::server]) {
    fail('You must define the dhcp::server class')
  }

  if ! $primary.is_a(String) {
    fail('Primary not a string')
  }

  if ! $key.is_a(String) {
    fail('Key is not a string')
  }

  concat::fragment{"zone_${name}":
    target  => $dhcp_config,
    content => template('dhcp/zone.erb'),
    order   => 30,
  }
}