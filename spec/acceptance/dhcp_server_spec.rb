require 'spec_helper_acceptance'

describe 'dhcp::server class' do
  let(:manifest) {
    <<-EOS
      class {'::dhcp::server': }
    EOS
  }

  it 'should run without errors' do
    result = apply_manifest(manifest, :catch_failures => true)
    expect(@result.exit_code).to eq 2
  end
end
