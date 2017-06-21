class cis_rhel7::restartsshd {
  exec { 'restart ssh daemon':
    path        => ['/sbin','/bin'],
    command     => 'systemctl restart sshd',
    refreshonly => true,
  }
}