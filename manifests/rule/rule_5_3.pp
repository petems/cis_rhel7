class cis_rhel7::rule::rule_5_3 (

  $logs = lookup({'name' => 'cis_rhel7::logs', 'default_value' => {}, 'merge' => {'strategy' => 'deep', 'merge_hash_arrays' => true}})

) {
  # includes Rules:
  # 5.3 - Configure logrotate (Not Scored)
  $file = '/etc/logrotate.d/syslog'

  file { $file:
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => epp('cis_rhel7/logrotate_syslog.epp',{ logs => $logs }),
  }

} #EOF
