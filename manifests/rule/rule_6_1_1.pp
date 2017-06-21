class cis_rhel7::rule::rule_6_1_1 (

  $files = lookup({'name' => 'cis_rhel7::cron_files', 'default_value' => {}, 'merge' => {'strategy' => 'deep', 'merge_hash_arrays' => true}}),
  $dirs  = lookup({'name' => 'cis_rhel7::cron_dirs', 'default_value' => {}, 'merge' => {'strategy' => 'deep', 'merge_hash_arrays' => true}})

) {

  # includes Rules:
  # 6.1.1 - Enable anacron Daemon (Scored)
  # 6.1.2 - Enable crond Daemon (Scored)
  # 6.1.3 - Set User/Group Owner and Permission on /etc/anacrontab (Scored)
  # 6.1.4 - Set User/Group Owner and Permission on /etc/crontab (Scored)
  # 6.1.5 - Set User/Group Owner and Permission on /etc/cron.hourly (Scored)
  # 6.1.6 - Set User/Group Owner and Permission on /etc/cron.daily (Scored)
  # 6.1.7 - Set User/Group Owner and Permission on /etc/cron.weekly (Scored)
  # 6.1.8 - Set User/Group Owner and Permission on /etc/cron.monthly (Scored)
  # 6.1.9 - Set User/Group Owner and Permission on /etc/cron.d (Scored)
  # 6.1.10   - Restrict at Daemon (Scored)
  # 6.1.10.1 - Verify That /etc/at.deny File Does Not Exist (Scored)
  # 6.1.11   - Restrict at/cron to Authorized Users (Scored)
  # 6.1.11.1 - Restrict at/cron to Authorized Users (Scored)

  package { '(6.1.1) - Anacron installed':
    name   => 'cronie-anacron',
    ensure => present,
  }

  service { '(6.1.2) - crond service is enabled':
    name   => 'crond',
    ensure => running,
    enable => true,
  }

  $files.each |$file, $desc| {
    file { "${desc} permissions":
      ensure => present,
      path   => $file,
      mode   => '0600',
      owner  => root,
      group  => root,
    }
  }

  $dirs.each|$dir, $desc| {
    file {"${desc} permissions":
      ensure => directory,
      path   => $dir,
      mode   => '0700',
      owner  => root,
      group  => root,
    }
  }

  #each($files) |$item| {
  #
  #  $file = split($item,'%')
  #
  #  file { "(${file[1]}) - ${file[0]} permissions":
  #    ensure => file,
  #    path   =>  $file[0],
  #    mode   => '0600',
  #    owner  => 'root',
  #    group  => 'root',
  #  }
  #}
  #
  #each($dirs) |$item2| {
  #
  #  $dir = split($item2,'%')
  #
  #  file { "(${dir[1]}) - ${dir[0]} permissions":
  #    ensure => directory,
  #    path   => $dir[0],
  #    mode   => '0700',
  #    owner  => root,
  #    group  => root,
  #  }
  #}

  file { '(6.1.10.1) delete /etc/at.deny file':
    path   => '/etc/at.deny',
    ensure => absent,
  }

  file { '(6.1.11.1) delete /etc/cron.deny file':
    path   => '/etc/cron.deny',
    ensure => absent,
  }

} #EOF
