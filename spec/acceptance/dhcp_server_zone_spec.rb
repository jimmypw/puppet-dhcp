require 'spec_helper_acceptance'

describe 'dhcp::server::zone defined type' do
  let(:manifest) do
    <<-EOS
      class {'::dhcp::server': }
      dhcp::server::key{'testkey':
        algorithm => 'testalg',
        secret    => 'testsec'
      }
      dhcp::server::zone{'testzone':
        primary => 'testp',
        key     => 'testkey'
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

  it 'creates a zone block' do
    result = shell('grep -E \'zone\s+testzone\s+{$\' /etc/dhcp/dhcpd.conf')
    expect(result.exit_code).to eq 0
  end

  it 'sets primary' do
    result = shell('grep -E \'primary\s+testp;$\' /etc/dhcp/dhcpd.conf')
    expect(result.exit_code).to eq 0
  end

  it 'sets key' do
    result = shell('grep -E \'key\s+testkey;$\' /etc/dhcp/dhcpd.conf')
    expect(result.exit_code).to eq 0
  end

  it 'closes the host block' do
    result = shell('tail -2 /etc/dhcp/dhcpd.conf | grep -E \'}$\' ')
    expect(result.exit_code).to eq 0
  end
end