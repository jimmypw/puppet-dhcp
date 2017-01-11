class dhcp::server::params {
  $authoritative       = false
  $dhcpd_config        = '/etc/dhcp/dhcpd.conf'
  $log_facility        = 'local7'
  $domain_name         = 'example.org'
  $domain_name_servers = 'ns1.example.org, ns2.example.org'
  $default_lease_time  = '600'
  $min_lease_time      = '60'
  $max_lease_time      = '7200'
  $next_server         = undef
  $ddns_updates        = false
  $ddns_update_style   = 'none'
  $omapi_port          = undef
  case $::osfamily {
    'RedHat': {
      $packagename = 'dhcp'
      $servicename = 'dhcpd'
    }
    'Debian': {
      $packagename = 'isc-dhcp-server'
      $servicename = 'isc-dhcp-server'
    }
    default:  {
      fail('OS Not supported')
    }
  }
    
}
