#
# Cookbook Name:: cloudstack
# Recipe:: nfs
#
# Copyright 2012-2013, CREATIONLINE,INC.
#
# All rights reserved
#

#
# include required recipes
#
include_recipe 'cloudstack::common'

#
# install nfs-utils
#
package 'nfs-utils'

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
  supports :restart => true
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
  notifies :restart, resources( :service => 'nfs' )
end

#
# mkdir storage NFS sharing (primary/secondary)
#
[ node[ 'cloudstack' ][ 'nfs_primary_dir'   ],
  node[ 'cloudstack' ][ 'nfs_secondary_dir' ] ].each do |dir|
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
  notifies :restart, resources( :service => 'nfs' )
end

#
# modify /etc/sysconfig/nfs and restart nfs
#
template '/etc/sysconfig/nfs' do
  source 'nfs.erb'
  owner 'root'
  group 'root'
  mode 0644
  notifies :restart, resources( :service => 'nfs' )
end

#
# modify /etc/sysconfig/iptables and restart iptables
#
service 'iptables' do
  supports :restart => true
  action :enable
end
template '/etc/sysconfig/iptables' do
  source 'iptables.erb'
  owner 'root'
  group 'root'
  mode 0600
  notifies :restart, resources( :service => 'iptables' )
end

#
# download system vm
#
remote_file "#{node[ 'cloudstack' ][ 'nfs_root_dir' ]}/#{node[ 'cloudstack' ][ 'systemvm_filename' ]}" do
  source "#{node[ 'cloudstack' ][ 'systemvm_base_uri' ]}#{node[ 'cloudstack' ][ 'systemvm_filename' ]}"
  checksum node[ 'cloudstack' ][ 'systemvm_sha256' ]
  mode 0644
end

#
# [EOF]
#
