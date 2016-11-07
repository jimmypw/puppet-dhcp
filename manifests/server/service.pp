class dhcp::server::service {
  service {'isc-dhcp-server' :
    ensure => running,
    # Following line disabled as it breaks puppet with :
    # Could not evaluate: invalid byte sequence in US-ASCII
    # enable => true,
  }
}
