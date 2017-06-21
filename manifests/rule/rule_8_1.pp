class cis_rhel7::rule::rule_8_1  (

  $banners = lookup({'name' => 'cis_rhel7::banners', 'default_value' => {}, 'merge' => {'strategy' => 'deep', 'merge_hash_arrays' => true}})

) {

#includes Rules:
# 8.1 - Set Warning Banner for Standard Login Services (Scored)
# 8.2 - Remove OS Information from Login Warning Banners (Scored)
$banners.each |$banner| {
  file { "(8.1) - ${banner} exists":
      ensure  => file,
      path    => $banner,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => epp('cis_rhel7/banner.epp')
  }
}

} #EOF
