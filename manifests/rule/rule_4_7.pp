class cis_rhel7::rule::rule_4_7 {

  # includes Rules:
  # 4.7 - Enable firewalld (Scored)

  package {'(4.7) - ensure firewalld is installed':
    ensure => present,
    name   => 'firewalld',
  }
  -> service { '(4.7) - firewalld enabled':
    ensure => running,
    name   => 'firewalld',
  }

} #EOF
