class cis_rhel7::rule::rule_1_3_2 {
  # includes Rules:
  # 1.3.2 - Implement Periodic Execution of File Integrity (Scored)

  file { '/etc/cron.d/AIDE':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0600',
    content => '0 5 * * * /usr/sbin/aide --check',
  }

} #EOF
