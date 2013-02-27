#
# Cookbook Name:: cloudstack
# Environment:: cloudstack30
#
# Copyright 2013, CREATIONLINE,INC.
#
# All rights reserved
#
name 'cloudstack30'
description 'CloudStack 3.0'

override_attributes(
  'cloudstack' => {
    'version' => '3.0',
    'tarball_base_uri'  => 'http://download.cloud.com/releases/3.0.6/',
    'tarball_basename'  => 'CloudStack-3.0.6-1-rhel6.2',
    'tarball_sha256'    => 'cd1683129c9a7043d61ee6ee746ad8cfb9a5e04bc50d3eab2c7b5900825fd971',
    'systemvm_base_uri' => 'http://download.cloud.com/templates/acton/',
    'systemvm_filename' => 'acton-systemvm-02062012.qcow2.bz2',
    'systemvm_sha256'   => '67dfc81297368ce605449454776a97d69f5c7bf5f90dbfe9cb49046fea3fff8a',
    'cloud-install-sys-tmplt' => '/usr/lib64/cloud/agent/scripts/storage/secondary/cloud-install-sys-tmplt',
    'mgmt_ipaddr'       => '192.168.122.110',
    'mgmt_fqdn'         => 'cs3-manager.example.jp',
    'mgmt_hostname'     => 'cs3-manager',
    'nfs_ipaddr'        => '192.168.122.111',
    'nfs_fqdn'          => 'cs3-nfs.example.jp',
    'nfs_hostname'      => 'cs3-nfs',
    'host_ipaddr'       => '192.168.122.112',
    'host_fqdn'         => 'cs3-host.example.jp',
    'host_hostname'     => 'cs3-host',
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
