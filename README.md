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

The rules that require manual intervention are not part of the scope.

## Setup

clone the module:
    git clone https://github.com/bossbear/cis_rhel7.git

(See Usage for staging dependent modules)

### What cis_rhel7 affects

Pretty much the entire system.

### Setup Requirements

This module requires 4 additional modules

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

## Limitations

This module was tested using Puppet Agent 4.9.4 and have been tested on following systems:

1. RedHat 7 x64
2. CentOS 7 x64

While beaker testing using docker has been created, vagrant testing frame work has not.


## Development
TODO: CIS 1.1.0 is out.  Make code adjustments accordingly

TODO: Write Vagrant beaker testing and ensure that all rules can be tested in an emulated environment
