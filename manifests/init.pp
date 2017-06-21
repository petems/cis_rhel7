# Based on the following document:
# CIS_Red_Hat_Enterprise_Linux_7_Benchmark_v1.0.0.pdf

class cis_rhel7 (

  $execcontrol = lookup({'name' => 'cis_rhel7::execcontrol', 'default_value' => {}, 'merge' => {'strategy' => 'deep', 'merge_hash_array' => true}})

) {

  ## Rules: loop through the execcontrol hash and run the ones marked 'true'
  $execcontrol.each |$rule, $ishouldexecute| {
    if $ishouldexecute { include "::cis_rhel7::rule::${rule}" }
  }

} #EOF
