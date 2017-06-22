class cis_rhel7::rule::rule_3_8 (
  $nfsservices = lookup ({'name' => 'cis_rhel7::nfs_services', 'default_value' => {}, 'merge' => {'strategy' => 'deep', 'merge_hash_arrays' => true}})
) {

  # includes Rules:
  # 3.8 - Disable NFS and RPC (Not Scored)

  $nfsservices.each |$service| {
    service {"(3.8) - ${service} disabled":
      ensure => stopped,
      name   => $service,
      enable => false,
    }
  }

} #EOF
