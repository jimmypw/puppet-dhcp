class dhcp::server::service {
  service {'isc-dhcp-server' :
    ensure => running,
    enable => true,
  }
}