#
# Cookbook Name:: cloudstack
# Environment:: cloudstack22
#
# Copyright 2013, CREATIONLINE,INC.
#
# All rights reserved
#
name 'cloudstack22'
description 'CloudStack 2.2'

override_attributes(
  'cloudstack' => {
    'version' => '2.2',
    'tarball_base_uri'  => 'http://jaist.dl.sourceforge.net/project/cloudstack/Cloudstack%202.2/2.2.14/',
    'tarball_basename'  => 'CloudStack-2.2.14-1-rhel6.2',
    'tarball_sha256'    => '694df2811d1d4e59646d9e68447a7f6d8f69952de45a28aca81d50394302eeff',
    'systemvm_base_uri' => 'http://download.cloud.com/releases/2.2.0/',
    'systemvm_filename' => 'systemvm.qcow2.bz2',
    'systemvm_sha256'   => '0f6b1e7b2ead2f521ae9d883087e6d0c1fe523496bd774b16a42b320e8c8c57c',
    'cloud-install-sys-tmplt' => '/usr/lib64/cloud/agent/scripts/storage/secondary/cloud-install-sys-tmplt',
    'mgmt_ipaddr'       => '192.168.122.110',
    'mgmt_fqdn'         => 'cs2-manager.example.jp',
    'mgmt_hostname'     => 'cs2-manager',
    'nfs_ipaddr'        => '192.168.122.111',
    'nfs_fqdn'          => 'cs2-nfs.example.jp',
    'nfs_hostname'      => 'cs2-nfs',
    'host_ipaddr'       => '192.168.122.112',
    'host_fqdn'         => 'cs2-host.example.jp',
    'host_hostname'     => 'cs2-host',
    'domainname'        => 'example.jp',
    'mysql_root_name'   => 'root',
    'mysql_root_pass'   => 'myroot1234',
    'mysql_user_name'   => 'cloud',
    'mysql_user_pass'   => 'myuser1234',
    'nfs_root_dir'      => '/export',
    'nfs_primary_dir'   => 'primary',
    'nfs_secondary_dir' => 'secondary'
  }
)

#
# [EOF]
#
