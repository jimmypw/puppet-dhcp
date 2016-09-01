require 'spec_helper'

describe 'dhcp::server::zone' do
  let(:pre_condition) do
    'include "::dhcp::server"'
  end

  let (:params) do
    {
      'primary' => 'foo',
      'key'     => 'baa'
    }
  end

  let(:title) do
    'foo'
  end

  context 'with default values for all parameters' do
    it { is_expected.to compile }
    it { is_expected.to contain_concat__fragment('zone_foo')}
  end
end