class dhcp::server::install {
  package { $dhcp::server::packagename:
    ensure => installed,
  }
}
