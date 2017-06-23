Facter.add(:cis_rhel7_nodegroup) do
  setcode do
    if File.exist?('/etc/.cis_rhel7_nodegroup')
      Facter::Core::Execution.exec('cat /etc/.cis_rhel7_nodegroup')
    end
  end
end
