require 'spec_helper'

describe 'dhcp::server::key' do
  let(:pre_condition) do
    'include "::dhcp::server"'
  end

  let (:params) do
    {
      'algorithm' => 'foo',
      'secret'    => 'baa'
    }
  end

  let(:title) do
    'foo'
  end

  context 'with default values for all parameters' do
    it { is_expected.to compile }
    it { is_expected.to contain_concat__fragment('key_foo')}
  end
end