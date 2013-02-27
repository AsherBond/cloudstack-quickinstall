#
# Cookbook Name:: cloudstack
# Environment:: cloudstack40
#
# Copyright 2013, CREATIONLINE,INC.
#
# All rights reserved
#
name 'cloudstack40'
description 'CloudStack 4.0'

override_attributes(
  'yum' => {
    'cloudstack' => {
      'url' => 'http://cloudstack.apt-get.eu/rhel/4.0/'
    }
  },
  'cloudstack' => {
    'version' => '4.0',
    'systemvm_base_uri' => 'http://download.cloud.com/templates/acton/',
    'systemvm_filename' => 'acton-systemvm-02062012.qcow2.bz2',
    'systemvm_sha256'   => '67dfc81297368ce605449454776a97d69f5c7bf5f90dbfe9cb49046fea3fff8a',
    'cloud-install-sys-tmplt' => '/usr/lib64/cloud/common/scripts/storage/secondary/cloud-install-sys-tmplt',
    'mgmt_ipaddr'       => '192.168.122.110',
    'mgmt_fqdn'         => 'cs4-manager.example.jp',
    'mgmt_hostname'     => 'cs4-manager',
    'nfs_ipaddr'        => '192.168.122.111',
    'nfs_fqdn'          => 'cs4-nfs.example.jp',
    'nfs_hostname'      => 'cs4-nfs',
    'host_ipaddr'       => '192.168.122.112',
    'host_fqdn'         => 'cs4-host.example.jp',
    'host_hostname'     => 'cs4-host',
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
