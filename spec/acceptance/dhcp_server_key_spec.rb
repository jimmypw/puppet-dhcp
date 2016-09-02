require 'spec_helper_acceptance'

describe 'dhcp::server::key defined type' do
  let(:manifest) do
    <<-EOS
      class {'::dhcp::server': }
      dhcp::server::key{'testkey':
        algorithm => 'testalg',
        secret    => 'testsec'
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

  it 'creates a key block' do
    result = shell('grep -E \'key\s+"testkey"\s+{$\' /etc/dhcp/dhcpd.conf')
    expect(result.exit_code).to eq 0
  end

  it 'sets algorithm' do
    result = shell('grep -E \'algorithm testalg;$\' /etc/dhcp/dhcpd.conf')
    expect(result.exit_code).to eq 0
  end

  it 'sets secret' do
    result = shell('grep -E \'secret\s+"testsec";$\' /etc/dhcp/dhcpd.conf')
    expect(result.exit_code).to eq 0
  end

  it 'closes the key block' do
    result = shell('tail -2 /etc/dhcp/dhcpd.conf | grep -E \'}$\' ')
    expect(result.exit_code).to eq 0
  end
end