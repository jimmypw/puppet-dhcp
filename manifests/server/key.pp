define dhcp::server::key (
  $algorithm   = undef,
  $secret      = undef,
  $dhcp_config = $::dhcp::server::dhcpd_config
)
{

  if ! defined(Class[::dhcp::server]) {
    fail('You must define the dhcp::server class')
  }

  if $algorithm == undef{
    fail('Algorithm not defined')
  }

  if $secret == undef {
    fail('Secret not defined')
  }

  concat::fragment{"key_${name}":
    target  => $dhcp_config,
    content => template('dhcp/key.erb'),
    order   => 30,
  }
}