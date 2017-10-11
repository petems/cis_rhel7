class cis_rhel7::rule::rule_4_1_1 {
  # includes Rules:
  # 4.1.1 - Disable IP Forwarding (Scored)
  # 4.1.2 - Disable Send Packet Redirects (Scored)

  $file = '/etc/sysctl.conf'

  sysctl { 'net.ipv4.ip_forward':
    ensure    => present,
    value     => '0',
  }

  sysctl { 'net.ipv4.conf.all.send_redirects':
    ensure    => present,
    value     => '0',
  }
  sysctl {'net.ipv4.conf.default.send_redirects':
    ensure    => present,
    value     => '0',
  }

} #EOF
