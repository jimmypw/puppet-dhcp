require 'spec_helper'

describe 'dhcp::server::config' do
  let(:pre_condition) do
    'include "::dhcp::server"'
  end

  let(:facts) do
    {
      'osfamily' => 'Debian'
    }
  end 

  context 'with default values for all parameters' do
    it { is_expected.to compile }
    it { is_expected.to contain_concat('/etc/dhcp/dhcpd.conf') }
    it { is_expected.to contain_concat__fragment('main')}
  end
end
