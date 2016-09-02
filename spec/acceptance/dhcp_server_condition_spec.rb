require 'spec_helper_acceptance'

describe 'dhcp::server::condition defined type' do
  let(:manifest) do
    <<-EOS
      class {'::dhcp::server': }
      dhcp::server::condition{'testcondition':
        condition => 'test_c',
        ontrue    => 'test_t',
        onfalse   => 'test_f'
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

  it 'creates a test condition' do
    result = shell('grep -E \'if\s+test_c\s+{$\' /etc/dhcp/dhcpd.conf')
    expect(result.exit_code).to eq 0
  end

  it 'creates onTrue condition' do
    result = shell('grep -E \'test_t;$\' /etc/dhcp/dhcpd.conf')
    expect(result.exit_code).to eq 0
  end

  it 'creates an else condition' do
    result = shell('grep -C 2 -E \'test_t\' /etc/dhcp/dhcpd.conf | grep -E \'}\s+else\s+{$\'')
    expect(result.exit_code).to eq 0
  end

  it 'creates an onFalse condition' do
    result = shell('grep -E \'test_f;$\' /etc/dhcp/dhcpd.conf')
    expect(result.exit_code).to eq 0
  end

  it 'creates an onFalse condition' do
    result = shell('grep -C 2 -E \'test_f\' /etc/dhcp/dhcpd.conf | grep -E \'}$\'')
    expect(result.exit_code).to eq 0
  end
end