require 'spec_helper'
describe 'cis_rhel7' do
  let(:facts) do
  {
    :osfamily => 'RedHat',
    :operatingsystem => 'RedHat',
    :operatingsystemrelease => '7.1',
    :operatingsystemmajrelease => '7',
    :kernelversion => '3.10.0',
    :cis_benchmarks => { 'ww_dirs' => 'ww_dirs' }
  }
  end

  context 'with default values for all parameters' do
    it { should contain_class('cis_rhel7') }
  end
end
