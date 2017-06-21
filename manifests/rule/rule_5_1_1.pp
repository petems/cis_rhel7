class cis_rhel7::rule::rule_5_1_1 (

  $remotelogserver = lookup({'name' => 'cis_rhel7::remotelogserver', 'default_value' => {}, 'merge' => {'strategy' => 'deep', 'merge_hash_arrays' => true}}),
  $rsyslogcontent = lookup({'name' => 'cis_rhel7::rsyslogcontent', 'default_value' => {}, 'merge' => {'strategy' => 'deep', 'merge_hash_arrays' => true}})

) {

$file = '/etc/rsyslog.conf'

# includes Rules:
# 5.1.1 - Install the rsyslog package (Scored)
# 5.1.2 - Activate the rsyslog Service (Scored)
# 5.1.3 - Configure /etc/rsyslog.conf (Not Scored)
# 5.1.4 - Create and Set Permissions on rsyslog Log Files (Scored)
# 5.1.5 - Configure rsyslog to Send Logs to a Remote Log Host (Scored)
# 5.1.6 - Accept Remote rsyslog Messages Only on Designated Log Hosts (Not Scored)

package { '(5.1.1) - Rsyslog installed':
  name   => 'rsyslog',
  ensure => installed,
}

service { '(5.1.2) - Rsyslog service running':
  name      => 'rsyslog',
  ensure    => running,
  subscribe => File['(5.1.3) - /etc/rsyslog.conf exists'],
}

file { "(5.1.3) - ${file} exists":
  name    => $file,
  ensure  => file,
  mode    => '0600',
  owner   => 'root',
  group   => 'root',
  require => Package['(5.1.1) - Rsyslog installed'],
}

$rsyslogcontent.each |$facility, $destlog| {
  $logfile = regsubst ($destlog,'^-','')

  file_line { "(5.1.3) - ${file}: contains  ${logfile}":
    path   => $file,
    ensure => present,
    line   => "${facility} ${destlog}",
  }

  file { "(5.1.4) - ${logfile} permissions: 0600":
    ensure => present,
    path   => $logfile,
    mode   => '0600',
    owner  => root,
    group  => root,
  }
}

file_line { "(5.1.5) - ${file}: Remote host configured":
  ensure  => present,
  path    => $file,
  line    => "*.* @@${remotelogserver}",
  match   => '^*.*.@@.*$',
  replace => true
}

file_line { "(5.1.6) - ${file}: \$ModLoad imtcp.so":
  ensure => present,
  path   => $file,
  line   => '$ModLoad imtcp.so',
}

file_line { "(5.1.6) - ${file}: \$InputTCPServerRun 514":
  ensure => present,
  path   => $file,
  line   => '$InputTCPServerRun 514',
}

} #EOF
