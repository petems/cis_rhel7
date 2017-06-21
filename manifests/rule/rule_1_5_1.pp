class cis_rhel7::rule::rule_1_5_1 {

# includes Rules:
# 1.5.1 - Set User/Group Owner on /boot/grub2/grub.cfg (Scored)
# 1.5.2 - Set Permissions on /etc/grub.conf (Scored)
# 1.5.3 - 1.5.3 Set Boot Loader Password (Scored)

$file = '/boot/grub2/grub.cfg'
$sourcefile = '/etc/grub.d/40_custom'
$grubpwd = lookup({'name' => 'cis_rhel7::grubpwd', 'default_value' => {}, 'merge' => {'strategy' => 'deep', 'merge_hash_arrays' => true}})

file { "(1.5.1 - 1.5.2) - ${file} ownership":
  path   => $file,
  ensure => file,
  owner  => 'root',
  group  => 'root',
  mode   => '0400',
}

file_line { "(1.5.3) - set superusers in ${file}":
  ensure => present,
  path   => $sourcefile,
  line   => 'set superusers="root"',
}

file_line { "(1.5.3) - set password in ${file}":
  ensure => present,
  path   => $sourcefile,
  line   => $grubpwd,
}

exec { 'updategrub':
  command     => "/sbin/grub2-mkconfig -o ${file} && /bin/chmod 0400 ${file}",
  refreshonly => true,
  subscribe   => [ File_line["(1.5.3) - set password in ${file}"], File_line["(1.5.3) - set superusers in ${file}"]],
}


} #EOF
