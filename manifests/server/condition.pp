define dhcp::server::condition (
  $condition   = undef,
  $ontrue      = undef,
  $onfalse     = undef,
  $dhcp_config = $::dhcp::server::params::dhcpd_config
)
{

  if ! defined(Class[::dhcp::server]) {
    fail('You must define the dhcp::server class')
  }

  if $condition == undef{
    fail('Condition not defined')
  }

  if $ontrue == undef{
    fail('Ontrue not defined')
  }

  if $onfalse == undef{
    fail('Onfalse not defined')
  }

  concat::fragment{"condition_${name}":
    target  => $dhcp_config,
    content => template('dhcp/condition.erb'),
    order   => 30,
  }
}