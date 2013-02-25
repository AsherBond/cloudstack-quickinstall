#
# Cookbook Name:: cloudstack
# Recipe:: common
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
include_recipe 'selinux::permissive'
include_recipe 'ntp'

#
# add CloudStack 4.0.x RPM package repository
#
if version =~ /^4\.0\.\d$/
  include_recipe 'yum'

  yum_repository 'cloudstack' do
    description 'CloudStack RPM package repository'
    url         node[ 'yum' ][ 'cloudstack' ][ 'url' ]
    includepkgs node[ 'yum' ][ 'cloudstack' ][ 'includepkgs' ]
    exclude     node[ 'yum' ][ 'cloudstack' ][ 'exclude' ]
    action :create
  end
end

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
# download and unarchive CloudStack 2.x/3.x tarball
#
if version =~ /^[23]\.\d\.\d+$/
  remote_file "/root/#{node[ 'cloudstack' ][ version ][ 'tarball_basename' ]}.tar.gz" do
    source "#{node[ 'cloudstack' ][ version ][ 'tarball_base_uri' ]}#{node[ 'cloudstack' ][ version ][ 'tarball_basename' ]}.tar.gz"
    checksum node[ 'cloudstack' ][ version ][ 'tarball_sha256' ]
    mode 0644
  end

  execute 'untar-cloudstack' do
    cwd '/root'
    command "tar xfz #{node[ 'cloudstack' ][ version ][ 'tarball_basename' ]}.tar.gz"
  end
end

#
# [EOF]
#
