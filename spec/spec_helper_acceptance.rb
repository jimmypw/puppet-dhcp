require 'beaker-rspec'
require 'pry'

# Install Puppet on all hosts
hosts.each do |host|
  install_puppet_on(host)
end

RSpec.configure do |c|
  module_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  c.formatter = :documentation

  c.before :suite do
    # Install module to all hosts
    hosts.each do |host|
      install_dev_puppet_module_on(host, :source => module_root, :module_name => 'dhcp',
          :target_module_path => '/etc/puppet/modules')
      # Install dependencies
      on(host, puppet('module', 'install', 'puppetlabs-concat'))
      on(host, puppet('module', 'install', 'puppetlabs-stdlib'))

      # Add more setup code as needed
    end
  end
end

