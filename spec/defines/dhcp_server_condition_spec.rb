require 'spec_helper'

describe 'dhcp::server::condition' do
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
      'condition' => 'foo',
      'ontrue'    => 'bim',
      'onfalse'   => 'baa'
    }
  end

  let(:title) do
    'foo'
  end

  context 'with default values for all parameters' do
    it { is_expected.to compile }
    it { is_expected.to contain_concat__fragment('condition_foo')}
  end
end