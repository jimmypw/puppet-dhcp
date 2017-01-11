require 'spec_helper'

OSTYPES.each do |v|
  describe 'dhcp::server::install' do
    let(:pre_condition) do
      'include "::dhcp::server"'
    end
    let(:facts) do
      {
        'osfamily' => v[:osfamily]
      }
    end 

    context 'with default values for all parameters' do
      it { is_expected.to compile }
      it { is_expected.to contain_package(v[:packagename])}
    end
  end
end
