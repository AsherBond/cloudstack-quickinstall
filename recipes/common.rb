#
# Cookbook Name:: cloudstack
# Recipe:: common
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
include_recipe 'selinux::permissive'
include_recipe 'ntp'

#
# modify /etc/hosts
#
template '/etc/hosts' do
  source 'hosts.erb'
  owner 'root'
  group 'root'
  mode 0644
end

#
# download CloudStack tarball
#
remote_file "/root/#{node[ 'cloudstack' ][ version ][ 'tarball_basename' ]}.tar.gz" do
  source "#{node[ 'cloudstack' ][ version ][ 'tarball_base_uri' ]}#{node[ 'cloudstack' ][ version ][ 'tarball_basename' ]}.tar.gz"
  checksum node[ 'cloudstack' ][ version ][ 'tarball_sha256' ]
  mode 0644
end

#
# unarchive CloudStack tarball
#
execute 'untar-cloudstack' do
  cwd '/root'
  command "tar xfz #{node[ 'cloudstack' ][ version ][ 'tarball_basename' ]}.tar.gz"
end

#
# [EOF]
#
