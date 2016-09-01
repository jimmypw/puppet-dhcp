require 'spec_helper'

describe 'dhcp::server::service' do
  context 'with default values for all parameters' do
    it { is_expected.to compile }
    it { is_expected.to contain_service('isc-dhcp-server').with(
        'ensure' => 'running',
        'enable' => 'true'
      ) 
    }
  end
end