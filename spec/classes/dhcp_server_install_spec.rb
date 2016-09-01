require 'spec_helper'

describe 'dhcp::server::install' do
  context 'with default values for all parameters' do
    it { is_expected.to compile }
    it { is_expected.to contain_package('isc-dhcp-server') }
  end
end