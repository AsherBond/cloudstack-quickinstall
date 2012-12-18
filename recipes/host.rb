#
# Cookbook Name:: cloudstack
# Recipe:: host
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
include_recipe 'yum::epel'
include_recipe 'cloudstack-quickinstall::common'

#
# install bridge-utils
#
package 'bridge-utils'

#
# install CloudStack host agent
#
execute 'install-cloudstack-host-agent' do
  cwd "/root/#{node[ 'cloudstack' ][ version ][ 'tarball_basename' ]}"
  command 'echo -e "A\ny" | ./install.sh'
end

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
# modify /etc/libvirt/qemu.conf and restart libvirtd
#
template '/etc/libvirt/qemu.conf' do
  source 'qemu.conf.erb'
  owner 'root'
  group 'root'
  mode 0644
end
service 'libvirtd' do
  action :restart
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
# [EOF]
#
