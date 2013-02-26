#
# Cookbook Name:: cloudstack
# Recipe:: host
#
# Copyright 2012-2013, CREATIONLINE,INC.
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
include_recipe 'yum::epel'
include_recipe 'cloudstack-quickinstall::common'

#
# install bridge-utils
#
package 'bridge-utils'

#
# install CloudStack host agent
#
if version =~ /^4\.0\.\d$/
  package 'cloud-agent'
elsif version =~ /^[23]\.\d\.\d+$/
  execute 'install-cloudstack-host-agent' do
    cwd "/root/#{node[ 'cloudstack' ][ version ][ 'tarball_basename' ]}"
    command 'echo -e "A\ny" | ./install.sh'
  end
end

#
# enable and start rpcbind
#
service 'rpcbind' do
  action [ :enable, :start ]
end

#
# modify /etc/idmapd.conf and restart nfs
#
service 'nfs' do
  supports :restart => true
  action [ :enable, :start ]
end
template '/etc/idmapd.conf' do
  source 'idmapd.conf.erb'
  owner 'root'
  group 'root'
  mode 0644
  notifies :restart, resources( :service => 'nfs' )
end

#
# modify /etc/libvirt/qemu.conf and restart libvirtd
#
service 'libvirtd' do
  supports :restart => true
  action [ :enable, :start ]
end
template '/etc/libvirt/qemu.conf' do
  source 'qemu.conf.erb'
  owner 'root'
  group 'root'
  mode 0644
  notifies :restart, resources( :service => 'libvirtd' )
end

#
# [EOF]
#
