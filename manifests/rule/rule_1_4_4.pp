class cis_rhel7::rule::rule_1_4_4 {

  # includes Rules:
  # 1.4.4 - Remove SETroubleshoot (Scored)
  # 1.4.5 - Remove MCS Translation Service (mcstrans) (Scored)

  package { '(1.4.4) - remove SETroubleshoot':
    ensure => absent,
    name   => 'setroubleshoot',
  }

  package { '(1.4.5) - remove MCS Translation Service':
    ensure => absent,
    name   => 'mcstrans',
  }

} #EOF
