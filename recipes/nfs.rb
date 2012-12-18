#
# Cookbook Name:: cloudstack
# Recipe:: nfs
#
# Copyright 2012, CREATIONLINE,INC.
#
# All rights reserved
#

#
# variable settings
#
version = node[ 'cloudstack' ][ 'version' ]

#
# include required recipes
#
include_recipe 'cloudstack-quickinstall::common'

#
# enable and start rpcbind
#
service 'rpcbind' do
  action [ :enable, :start ]
end

#
# enable and start nfs
#
service 'nfs' do
  action [ :enable, :start ]
end

#
# modify /etc/idmapd.conf
#
template '/etc/idmapd.conf' do
  source 'idmapd.conf.erb'
  owner 'root'
  group 'root'
  mode 0644
end

#
# mkdir storage NFS sharing (primary/secondary)
#
[ node[ 'cloudstack' ][ 'nfs_primary_dir' ], node[ 'cloudstack' ][ 'nfs_secondary_dir' ] ].each do |dir|
  directory "#{node[ 'cloudstack' ][ 'nfs_root_dir' ]}/#{dir}" do
    owner 'root'
    group 'root'
    mode 00755
    action :create
    recursive true
  end
end

#
# modify /etc/exports
#
template '/etc/exports' do
  source 'exports.erb'
  owner 'root'
  group 'root'
  mode 0644
end

#
# modify /etc/sysconfig/nfs
#
template '/etc/sysconfig/nfs' do
  source 'nfs.erb'
  owner 'root'
  group 'root'
  mode 0644
end
#
# restart nfs
#
service 'nfs' do
  action :restart
end

#
# modify /etc/sysconfig/iptables
#
template '/etc/sysconfig/iptables' do
  source 'iptables.erb'
  owner 'root'
  group 'root'
  mode 0600
end

#
# restart iptables
#
service 'iptables' do
  action :restart
end


#
# download system vm
#
remote_file "#{node[ 'cloudstack' ][ 'nfs_root_dir' ]}/#{node[ 'cloudstack' ][ version ][ 'systemvm_filename' ]}" do
  source "#{node[ 'cloudstack' ][ version ][ 'systemvm_base_uri' ]}#{node[ 'cloudstack' ][ version ][ 'systemvm_filename' ]}"
  checksum node[ 'cloudstack' ][ version ][ 'systemvm_sha256' ]
  mode 0644
end

#
# [EOF]
#
