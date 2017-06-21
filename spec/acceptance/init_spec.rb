require 'spec_helper_acceptance'

describe 'cis_rhel7 - default cis controls' do
  let(:manifest) {
    <<-EOS
      class {'cis_rhel7': }
    EOS
  }
  it 'should apply without errors' do
    apply_manifest(manifest, :catch_failures => true)
  end

  it 'should apply a secon time without changes' do
    @result = apply_manifest(manifest)
    expect(@result.exit_code).to be_zero
  end
end
