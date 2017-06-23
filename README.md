# cis_rhel7

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with cis_rhel7](#setup)
    * [What cis_rhel7 affects](#what-cis_rhel7-affects)
    * [Setup requirements](#setup-requirements)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

This is a puppet module that makes adjustments to RHEL/CentOS 7 systems in compliancy with CIS standard 1.0.0.

CIS standard can be found here:
https://benchmarks.cisecurity.org/tools2/linux/CIS_Red_Hat_Enterprise_Linux_7_Benchmark_v1.0.0.pdf

There were several modules that attempted to address CIS benchmark hardening.  What I found was that, most of the modules with the tag CIS did not do what it claimed to do.  Several modules simply did not run and it would've required for me to spend numerous hours just to get it running while others would run but score below 80% when scanned afterwards.

Thus, I decided to take a module as a base and
* Fill the gap so it would achieve 98% or above when scanned for CIS compliancy
* Refactor the code so that it would be much cleaner.

The features to highlight in this module as a result of refactoring are:
1. Instead of params.pp, hiera became the data provider
2. Cleaner code using Hiera hash lookup rather than accessing elements in arrays from params.pp which required parsing
3. Added execute control (cis_rhel7::execcontrol) in common.yaml so that one has an option to apply a rule or not
4. Added rule_specialperms.pp (and matching rule_specialperms hash in common.yaml) where one can add any extra hashes (file/dir: permission) to enforce permissions on files or directories

## Setup

clone the module:

    puppet module install bossbear-cis_rhel7
    OR
    git clone https://github.com/bossbear/cis_rhel7.git
(See Usage below for staging dependent modules)

### What cis_rhel7 affects

main list of subsystems impacted:
* sshd (and anything that requires authentication)
* auditd
* cron
* grub
* su
* kernel parameters
* network parameters
* selinux

### Setup Requirements

Currently, this module requires 4 additional modules:

1. puppetlabs-stdlib
2. herculesteam-augeasproviders_core
2. herculesteam-augeasproviders_pam
3. fiddyspence-sysctl

## Usage

Once you've cloned it you can run it two ways:

1. Stage all dependent modules in fixtures and run against spec/fixtures/modules directory.  Following the below steps as root:

        cd cis_rhel7
        bundle install --path vendor/bundle
        bundle exec rake spec_prep  #this will populate spec/fixtures/modules dir.
        puppet apply -v --modulepath spec/fixtures/modules examples/init.pp

2. Manually stage the dependent modules and run against /etc/puppetlabs/code/environment/production/modules directory:

        puppet module install puppetlabs-stdlib
        puppet module install herculesteam-augeasproviders_core
        puppet module install herculesteam-augeasproviders_pam
        puppet module install fiddyspence-sysctl
        cd cis_rhel7
        puppet apply -v --modulepath /etc/puppetlabs/code/environment/production/modules examples/init.pp

Obviously, you can add --noop flag to run things in an audit mode.

In order to run RSpec testing run the following commands:
   
    cd cis_rhel7
    bundle install --path vendor/path
    bundle exec rake spec

In order to run beaker testing run the following commands:

    cd cis_rhel7
    bundle install --path vendor/path
    bundle exec rake beaker:centos-7-x86_64-docker

## Custom cis_rhel7_custom.yaml
In some cases, a user may not want all CIS rules to be applied.  To accommodate that execcontrol hash has been created in common.yaml to enable or disable a rule.

However, in cases where a user would like to preserve common.yaml as default, one can create an empty /etc/.cis_rhel7_custom file which will cause cis_rhel7 module to use cis_rhel7_custom.yaml file instead.  Every hash or array in common.yaml can easily be replicated and altered in cis_rhel7_custom.yaml, whose effect can be reverted back by deleting /etc/.cis_rhel7_custom file.

NOTE: DO replicate ALL entries from common.yaml once the /etc/.cis_rhel7_custom control file is created.  Otherwise, the missing configuration in the yaml file will result in missing configuration in the system.

## Limitations

This module was tested using Puppet Agent 4.9.4 and have been tested on following systems:

1. RedHat 7 x64
2. CentOS 7 x64

While beaker testing using docker has been created, vagrant testing frame work has not.


## Development
TODO: CIS 1.1.0 is out.  Make code adjustments accordingly

TODO: Write Vagrant beaker testing and ensure that all rules can be tested in an emulated environment
