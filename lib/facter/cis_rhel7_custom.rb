Facter.add(:cis_rhel7_custom) do
  setcode do
    if File.exist?('/etc/.cis_rhel7_custom')
      'cis_rhel7_custom'
    else
      'common'
    end
  end
end
