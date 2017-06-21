require 'beaker-rspec'
require 'beaker/puppet_install_helper'

run_puppet_install_helper

RSpec.configure do |c|
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  c.formatter = :documentation

  c.before :suite do
    hosts.each do |host|

      # Install the module itself
      copy_module_to(host, :source => proj_root, :module_name => 'cis_rhel7')

      # HACK ALERT: need to over write cis_rhel7's init.pp with the one that does not use sysctl
      scp_to(host, 'spec/fixtures/beaker_init.pp', '/etc/puppetlabs/code/modules/cis_rhel7/manifests/init.pp')

      # Install the required base modules
      on host, puppet('module','install','--ignore-dependencies','puppetlabs/stdlib','--version=4.12.0')
      on host, puppet('module','install','--ignore-dependencies','herculesteam/augeasproviders_pam','--version=2.1.0')
      on host, puppet('module','install','--ignore-dependencies','herculesteam/augeasproviders_core','--version=2.1.3')
      on host, puppet('module','install','--ignore-dependencies','fiddyspence/sysctl','--version=1.1.0')
      on host, "yum -y install postfix"
      on host, "yum -y install audit"
    end
  end
end
