class cis_rhel7::rule::rule_4_5_1 {

  # includes Rules:
  # 4.5.1 - Install TCP Wrappers (Not Scored)

  package { '(4.5.1) - Install TCP Wrappers':
    ensure => present,
    name   => 'tcp_wrappers',
  }

} #EOF
