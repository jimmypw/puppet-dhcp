require 'spec_helper'

describe 'dhcp::server::host' do
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
      'mac'     => 'FF:FF:FF:FF:FF:FF',
      'address' => '192.168.1.1'
    }
  end

  let(:title) do
    'foo'
  end

  context 'with default values for all parameters' do
    it { is_expected.to compile }
    it { is_expected.to contain_concat__fragment('host_foo')}
  end
end