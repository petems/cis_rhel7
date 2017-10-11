class cis_rhel7::rule::rule_4_0 {

  # includes Rules:
  # 4.0 - Protects against SYN floods by establishing a ceiling on the number of open TCP connections

  # Use fiddyspence-sysctl module to handle all sysctl settings
  sysctl { 'net.ipv4.tcp_max_syn_backlog':
    ensure    => present,
    value     => '1024',
  }

} #EOF
