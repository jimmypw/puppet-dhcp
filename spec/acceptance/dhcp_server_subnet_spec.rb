require 'spec_helper_acceptance'

describe 'dhcp::server::subnet defined type' do
  let(:manifest) do
    <<-EOS
      class {'::dhcp::server': }
      dhcp::server::subnet{'10.10.10.0':
        netmask            => '255.255.255.0',
        broadcast          => '10.10.10.255',
        ranges             => ['10.10.10.10 10.10.10.20', '10.10.10.30 10.10.10.40'],
        routers            => ['10.10.10.1', '10.10.10.2'],
        domain_name        => 'test.local',
        options            => {
          'smtp-server' => '1.2.3.4'
        },
        default_lease_time => '50',
        max_lease_time     => '70'
      }
    EOS
  end

  it 'should run without errors' do
    result = apply_manifest(manifest, :catch_failures => true)
    expect(@result.exit_code).to eq 2
  end

  it 'should run a second time without changes' do
    result = apply_manifest(manifest, :catch_faulures => true)
    expect(@result.exit_code).to eq 0
  end

  it 'sets subnet' do
    result = shell('grep -E \'subnet\s+10.10.10.0\s+netmask\s+255.255.255.0\s+{$\' /etc/dhcp/dhcpd.conf')
    expect(@result.exit_code).to eq 0
  end

  it 'sets first range' do
    result = shell('grep -E \'range 10.10.10.10\s+10.10.10.20;$\' /etc/dhcp/dhcpd.conf')
    expect(@result.exit_code).to eq 0
  end

  it 'sets second range' do
    result = shell('grep -E \'range 10.10.10.30\s+10.10.10.40;$\' /etc/dhcp/dhcpd.conf')
    expect(@result.exit_code).to eq 0
  end

  it 'sets routers' do
    result = shell('grep -E \'option\s+routers\s+10.10.10.1,\s+10.10.10.2;$\' /etc/dhcp/dhcpd.conf')
    expect(@result.exit_code).to eq 0
  end

  it 'sets broadcast-address' do
    result = shell('grep -E \'option\s+broadcast-address\s+10.10.10.255;$\' /etc/dhcp/dhcpd.conf')
    expect(@result.exit_code).to eq 0
  end

  it 'sets default-lease-time' do
    result = shell('grep -E \'default-lease-time\s+50;$\' /etc/dhcp/dhcpd.conf')
    expect(@result.exit_code).to eq 0
  end

  it 'sets max-lease-time' do
    result = shell('grep -E \'max-lease-time\s+70;$\' /etc/dhcp/dhcpd.conf')
    expect(@result.exit_code).to eq 0
  end

  it 'sets domain-name' do
    result = shell('grep -E \'option\s+domain-name\s+"test.local";$\' /etc/dhcp/dhcpd.conf')
    expect(@result.exit_code).to eq 0
  end
end