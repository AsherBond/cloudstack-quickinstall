#
# Cookbook Name:: cloudstack
# Attribute:: default
#
# Copyright 2012, CREATIONLINE,INC.
#
# All rights reserved
#

#
# version setting
#
default[ 'cloudstack' ][ 'version' ] = '3.0.4'

#
# network settings
#
default[ 'cloudstack' ][ 'mgmt_ipaddr'   ] = '192.168.26.110'
default[ 'cloudstack' ][ 'mgmt_fqdn'     ] = 'cs-manager.example.jp'
default[ 'cloudstack' ][ 'mgmt_hostname' ] = 'cs-manager'
default[ 'cloudstack' ][ 'nfs_ipaddr'    ] = '192.168.26.111'
default[ 'cloudstack' ][ 'nfs_fqdn'      ] = 'cs-nfs.example.jp'
default[ 'cloudstack' ][ 'nfs_hostname'  ] = 'cs-nfs'
default[ 'cloudstack' ][ 'host_ipaddr'   ] = '192.168.26.112'
default[ 'cloudstack' ][ 'host_fqdn'     ] = 'cs-host.example.jp'
default[ 'cloudstack' ][ 'host_hostname' ] = 'cs-host'
default[ 'cloudstack' ][ 'domainname'    ] = 'example.jp'

#
# MySQL settings
#
default[ 'cloudstack' ][ 'mysql_root_name' ] = 'root'
default[ 'cloudstack' ][ 'mysql_root_pass' ] = 'myroot1234'
default[ 'cloudstack' ][ 'mysql_user_name' ] = 'cloud'
default[ 'cloudstack' ][ 'mysql_user_pass' ] = 'myuser1234'

#
# NFS settings
#
default[ 'cloudstack' ][ 'nfs_root_dir'      ] = '/export'
default[ 'cloudstack' ][ 'nfs_primary_dir'   ] = 'primary'
default[ 'cloudstack' ][ 'nfs_secondary_dir' ] = 'secondary'

#
# CloudStack 2.2.14
#
default[ 'cloudstack' ][ '2.2.14' ][ 'tarball_base_uri'  ] = 'http://jaist.dl.sourceforge.net/project/cloudstack/Cloudstack%202.2/2.2.14/'
default[ 'cloudstack' ][ '2.2.14' ][ 'tarball_basename'  ] = 'CloudStack-2.2.14-1-rhel6.2'
default[ 'cloudstack' ][ '2.2.14' ][ 'tarball_sha256'    ] = '694df2811d1d4e59646d9e68447a7f6d8f69952de45a28aca81d50394302eeff'
default[ 'cloudstack' ][ '2.2.14' ][ 'systemvm_base_uri' ] = 'http://download.cloud.com/releases/2.2.0/'
default[ 'cloudstack' ][ '2.2.14' ][ 'systemvm_filename' ] = 'systemvm.qcow2.bz2'
default[ 'cloudstack' ][ '2.2.14' ][ 'systemvm_sha256'   ] = '0f6b1e7b2ead2f521ae9d883087e6d0c1fe523496bd774b16a42b320e8c8c57c'

#
# CloudStack 3.0.4
#
default[ 'cloudstack' ][ '3.0.4' ][ 'tarball_base_uri'  ] = 'http://download.cloud.com/releases/3.0.4/'
default[ 'cloudstack' ][ '3.0.4' ][ 'tarball_basename'  ] = 'CloudStack-3.0.4-1-rhel6.2'
default[ 'cloudstack' ][ '3.0.4' ][ 'tarball_sha256'    ] = '0b9b3d38bd33bcf607250f0103f119f9dc5eb12848d58410187ecfbbdfba22a6'
default[ 'cloudstack' ][ '3.0.4' ][ 'systemvm_base_uri' ] = 'http://download.cloud.com/templates/acton/'
default[ 'cloudstack' ][ '3.0.4' ][ 'systemvm_filename' ] = 'acton-systemvm-02062012.qcow2.bz2'
default[ 'cloudstack' ][ '3.0.4' ][ 'systemvm_sha256'   ] = '67dfc81297368ce605449454776a97d69f5c7bf5f90dbfe9cb49046fea3fff8a'

#
# [EOF]
#
