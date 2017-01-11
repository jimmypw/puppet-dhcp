require 'spec_helper'

describe 'dhcp::server' do
  let(:facts) do
    {
      'osfamily' => 'Debian'
    }
  end 
  context 'with default values for all parameters' do
    it { is_expected.to compile }
    it { is_expected.to contain_class('dhcp::server::install') }
    it { is_expected.to contain_class('dhcp::server::config') }
    it { is_expected.to contain_class('dhcp::server::service') }
  end
end