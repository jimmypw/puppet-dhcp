require 'spec_helper_acceptance'

describe 'dhcp::server class' do
  let(:manifest) do
    <<-EOS
      class {'::dhcp::server': }
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

  it 'sets log-facility' do
    result = shell('grep -E \'log-facility\s+local7;$\' /etc/dhcp/dhcpd.conf')
    expect(@result.exit_code).to eq 0
  end


  it 'sets ddns-updates' do
    result = shell('grep -E \'ddns-updates\s+off;$\' /etc/dhcp/dhcpd.conf')
    expect(@result.exit_code).to eq 0
  end

  it 'sets ddns-update-style' do
    result = shell('grep -E \'ddns-update-style\s+none;$\' /etc/dhcp/dhcpd.conf')
    expect(@result.exit_code).to eq 0
  end

  it 'sets default-lease-time' do
    result = shell('grep -E \'default-lease-time\s+600;$\' /etc/dhcp/dhcpd.conf')
    expect(@result.exit_code).to eq 0
  end

  it 'sets min-lease-time' do
    result = shell('grep -E \'min-lease-time\s+60;$\' /etc/dhcp/dhcpd.conf')
    expect(@result.exit_code).to eq 0
  end

  it 'sets max-lease-time' do
    result = shell('grep -E \'max-lease-time\s+7200;$\' /etc/dhcp/dhcpd.conf')
    expect(@result.exit_code).to eq 0
  end

  it 'sets option domain-name' do
    result = shell('grep -E \'option\s+domain-name\s+"example.org";$\' /etc/dhcp/dhcpd.conf')
    expect(@result.exit_code).to eq 0
  end

  it 'sets option domain-name-servers' do
    result = shell('grep -E \'option\s+domain-name-servers\s+ns1.example.org,\s+ns2.example.org;$\' /etc/dhcp/dhcpd.conf')
    expect(@result.exit_code).to eq 0
  end
end