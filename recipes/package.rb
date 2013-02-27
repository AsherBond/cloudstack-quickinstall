#
# Cookbook Name:: cloudstack
# Recipe:: package
#
# Copyright 2012-2013, CREATIONLINE,INC.
#
# All rights reserved
#

case node[ 'cloudstack' ][ 'version' ]
#
# add CloudStack 4.0 RPM package repository
#
when '4.0'
  include_recipe 'yum'

  yum_repository 'cloudstack40' do
    description 'CloudStack 4.0 RPM package repository'
    url node[ 'yum' ][ 'cloudstack' ][ 'url' ]
    action :create
  end

#
# download and unarchive CloudStack 3.0/2.2 tarball
#
when '3.0', '2.2'
  remote_file "/root/#{node[ 'cloudstack' ][ 'tarball_basename' ]}.tar.gz" do
    source "#{node[ 'cloudstack' ][ 'tarball_base_uri' ]}#{node[ 'cloudstack' ][ 'tarball_basename' ]}.tar.gz"
    checksum node[ 'cloudstack' ][ 'tarball_sha256' ]
    mode 0644
  end

  execute 'untar-cloudstack' do
    cwd '/root'
    command "tar xfz #{node[ 'cloudstack' ][ 'tarball_basename' ]}.tar.gz"
  end
end

#
# [EOF]
#
