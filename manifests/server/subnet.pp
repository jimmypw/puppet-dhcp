define dhcp::server::subnet (
  $network            = $name,
  $netmask            = '255.255.255.0',
  $broadcast          = undef,
  $ranges             = [],
  $routers            = [],
  $domain_name        = undef,
  $options            = {},
  $default_lease_time = undef,
  $max_lease_time     = undef,
  $dhcp_config        = $::dhcp::server::dhcpd_config,
)
{

  if ! defined(Class[::dhcp::server]) {
    fail('You must define the dhcp::server class')
  }

  if ! $network.is_ip_address {
    fail('Network does not look like an ip address')
  }

  if ! $netmask.is_ip_address {
    fail('Netmask does not look like an ip address')
  }

  concat::fragment{"subnet_${name}":
    target  => $dhcp_config,
    content => template('dhcp/subnet.erb'),
    order   => 20,
  }
}