require 'spec_helper'

describe 'dhcp::server::subnet' do
  let(:facts) do
    {
      'osfamily' => 'RedHat'
    }
  end
  
  let(:pre_condition) do
    'include "::dhcp::server"'
  end

  let (:params) do
    {
      'network' => '192.168.1.1',
      'netmask' => '255.255.255.0',
    }
  end

  let(:title) do
    'foo'
  end

  context 'with default values for all parameters' do
    it { is_expected.to compile }
    it { is_expected.to contain_concat__fragment('subnet_foo')}
  end
end