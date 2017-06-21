class cis_rhel7::rule::rule_4_1_1 {

# includes Rules:
# 4.1.1 - Disable IP Forwarding (Scored)
# 4.1.2 - Disable Send Packet Redirects (Scored)


$file = '/etc/sysctl.conf'

#file_line { "(4.1.1) - ${file}: ip_forward=0":
#  ensure => present,
#  path   => $file,
#  line   => 'net.ipv4.ip_forward=0',
#  match  => '^net.ipv4.ip_forward',
#}
#file_line { "(4.1.2) - ${file}: all.send_redirects=0":
#  ensure => present,
#  path   => $file,
#  line   => 'net.ipv4.conf.all.send_redirects=0',
#  match  => '^net.ipv4.conf.all.send_redirects',
#}
#file_line { "(4.1.2) - ${file}: default.send_redirects=0":
#  ensure => present,
#  path   => $file,
#  line   => 'net.ipv4.conf.default.send_redirects=0',
#  match  => '^net.ipv4.conf.default.send_redirects',
#}

sysctl { 'net.ipv4.ip_forward':
  ensure    => present,
  permanent => yes,
  value     => '0',
}

sysctl { 'net.ipv4.conf.all.send_redirects':
  ensure    => present,
  permanent => yes,
  value     => '0',
}
sysctl {'net.ipv4.conf.default.send_redirects':
  ensure    => present,
  permanent => yes,
  value     => '0',
}

} #EOF
