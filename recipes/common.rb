#
# Cookbook Name:: cloudstack
# Recipe:: common
#
# Copyright 2012-2013, CREATIONLINE,INC.
#
# All rights reserved
#

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
# [EOF]
#
