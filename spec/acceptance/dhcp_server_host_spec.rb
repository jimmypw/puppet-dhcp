require 'spec_helper_acceptance'

describe 'dhcp::server::host defined type' do
  let(:manifest) do
    <<-EOS
      class {'::dhcp::server': }
      dhcp::server::host{'testhost':
        mac     => 'AB:AB:AB:AB:AB:AB',
        address => '10.20.30.40'
      }
    EOS
  end

  it 'should run without errors' do
    result = apply_manifest(manifest, :catch_failures => true)
    expect(result.exit_code).to eq 2
  end

  it 'should run a second time without changes' do
    result = apply_manifest(manifest, :catch_faulures => true)
    expect(result.exit_code).to eq 0
  end

  it 'creates a host block' do
    result = shell('grep -E \'host\s+testhost\s+{$\' /etc/dhcp/dhcpd.conf')
    expect(result.exit_code).to eq 0
  end

  it 'adds the mac address' do
    result = shell('grep -E \'hardware\s+ethernet\s+AB:AB:AB:AB:AB:AB;$\' /etc/dhcp/dhcpd.conf')
    expect(result.exit_code).to eq 0
  end

  it 'adds the ip address' do
    result = shell('grep -E \'fixed-address\s+10.20.30.40;$\' /etc/dhcp/dhcpd.conf')
    expect(result.exit_code).to eq 0
  end

  it 'closes the host block' do
    result = shell('grep -C 2 -E \'fixed-address\' /etc/dhcp/dhcpd.conf | grep -E \'}$\' ')
    expect(result.exit_code).to eq 0
  end
end