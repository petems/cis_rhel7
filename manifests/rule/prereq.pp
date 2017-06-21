class cis_rhel7::rule::prereq (
  $cis_scripts_dir = lookup({'name' => 'cis_rhel7::cis_scripts_dir', 'default_value' => {}, 'merge' => {'strategy' => 'deep', 'merge_hash_arrays' => true}}),
  $cis_scripts     = lookup({'name' => 'cis_rhel7::cis_scripts', 'default_value' => {}, 'merge' => {'strategy' => 'deep', 'merge_hash_arrays' => true}})
) {


### CIS BENCHMARK PREREQUISITE STEPS

# location for CIS shell scripts

file { $cis_scripts_dir :
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    noop   => false,
  }


# place CIS shell script on each node

each($cis_scripts) |$item| {

  file { "${cis_scripts_dir}/${item}":
    ensure => file,
    source => "puppet:///modules/cis_rhel7/${item}",
    mode   => '0755',
    noop   => false,
  }
}

} #EOF

