require 'puppetlabs_spec_helper/module_spec_helper'

OSTYPES = [
  {
    'osfamily': 'RedHat',
    'operatingsystem': 'RedHat',
    'operatingsystemrelease': '7',
    'packagename': 'dhcp',
    'servicename': 'dhcpd'
  },
  {
    'osfamily': 'RedHat',
    'operatingsystem': 'RedHat',
    'operatingsystemrelease': '6.8',
    'packagename': 'dhcp',
    'servicename': 'dhcpd'
  },
  {
    'osfamily': 'Debian',
    'operatingsystem': 'Ubuntu',
    'operatingsystemrelease': '14.04',
    'packagename': 'isc-dhcp-server',
    'servicename': 'isc-dhcp-server'
  }
]
