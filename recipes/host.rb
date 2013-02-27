#
# Cookbook Name:: cloudstack
# Recipe:: host
#
# Copyright 2012-2013, CREATIONLINE,INC.
#
# All rights reserved
#

#
# include required recipes
#
include_recipe 'cloudstack::common'
include_recipe 'cloudstack::package'

#
# install bridge-utils
#
package 'bridge-utils'

#
# install CloudStack host agent
#
case node[ 'cloudstack' ][ 'version' ]
when '4.0'
  package 'cloud-agent'
when '3.0', '2.2'
  include_recipe 'yum::epel'
  execute 'install-cloudstack-host-agent' do
    cwd "/root/#{node[ 'cloudstack' ][ 'tarball_basename' ]}"
    command 'echo -e "A\ny" | ./install.sh'
    not_if { ::File.exists?( '/usr/bin/cloud-setup-agent' ) }
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
