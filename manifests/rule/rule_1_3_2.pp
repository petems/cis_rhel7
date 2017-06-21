class cis_rhel7::rule::rule_1_3_2 {

# includes Rules:
# 1.3.2 - Implement Periodic Execution of File Integrity (Scored)


#cron { '(1.3.2) - AIDE is scheduled in cron':
#    name    => 'Run AIDE',
#    command => '/usr/sbin/aide --check',
#    user    => 'root',
#    minute  => 0,
#    hour    => 5,
#}

file { '/etc/cron.d/AIDE':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0600',
  content => '0 5 * * * /usr/sbin/aide --check',
}

##
## BNS SCC 1.3.2: Ensure that /var/spool/cron/root exist
##
file { '/var/spool/cron/root':
  ensure => present,
  owner  => root,
  group  => root,
  mode   => '0600',
}

} #EOF
