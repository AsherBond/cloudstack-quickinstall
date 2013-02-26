#
# Cookbook Name:: cloudstack
# Recipe:: manager
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
include_recipe 'cloudstack-quickinstall::common'

#
# mkdir storage NFS sharing (not_if mgmt == nfs)
#
if node[ 'cloudstack' ][ 'mgmt_ipaddr' ] == node[ 'cloudstack' ][ 'nfs_ipaddr' ]
  include_recipe 'cloudstack-quickinstall::nfs'
end

#
# install CloudStack management server
#
if version =~ /^4\.0\.\d$/
  package 'cloud-client'
elsif version =~ /^[23]\.\d\.\d+$/
  execute 'install-cloudstack-management-server' do
    cwd "/root/#{node[ 'cloudstack' ][ version ][ 'tarball_basename' ]}"
    command 'echo -e "M\ny" | ./install.sh'
  end
end

#
# install CloudStack database server
#
if version =~ /^4\.0\.\d$/
  package 'mysql-server' do
    action :install
    not_if '[ -f /var/cache/local/preseeding/cloudstack-mysql.seed ]'
  end
elsif version =~ /^[23]\.\d\.\d+$/
  execute 'install-cloudstack-database-server' do
    cwd "/root/#{node[ 'cloudstack' ][ version ][ 'tarball_basename' ]}"
    command 'echo -e "D\ny" | ./install.sh'
    not_if '[ -f /var/cache/local/preseeding/cloudstack-mysql.seed ]'
  end
end

#
# modify /etc/my.cnf and restart MySQL
#
service 'mysqld' do
  supports :restart => true
  action [ :enable, :start ]
end
template '/etc/my.cnf' do
  source 'my.cnf.erb'
  owner 'root'
  group 'root'
  mode 0644
  notifies :restart, resources( :service => 'mysqld' )
end

#
# set MySQL root password
#
execute 'set-mysql-root-password' do
  command %Q%echo -e "SET PASSWORD = PASSWORD('#{node[ 'cloudstack' ][ 'mysql_root_pass' ]}');\nexit\n" | mysql -u #{node[ 'cloudstack' ][ 'mysql_root_name' ]}%
  not_if '[ -f /var/cache/local/preseeding/cloudstack-mysql.seed ]'
end

#
# exec cloud-setup-databases
#
execute 'cloud-setup-databases' do
  command "cloud-setup-databases #{node[ 'cloudstack' ][ 'mysql_user_name' ]}:#{node[ 'cloudstack' ][ 'mysql_user_pass' ]}@localhost --deploy-as=#{node[ 'cloudstack' ][ 'mysql_root_name' ]}:#{node[ 'cloudstack' ][ 'mysql_root_pass' ]}"
  not_if '[ -f /var/cache/local/preseeding/cloudstack-mysql.seed ]'
end

#
# touch database setting done file
#
directory '/var/cache/local/preseeding' do
  owner 'root'
  group 'root'
  mode 00755
  action :create
  recursive true
end
execute 'touch /var/cache/local/preseeding/cloudstack-mysql.seed'

#
# exec cloud-setup-management
#
execute '/usr/bin/cloud-setup-management'

#
# mkdir storage NFS sharing (not_if mgmt == nfs)
#
directory node[ 'cloudstack' ][ 'nfs_root_dir' ] do
  owner 'root'
  group 'root'
  mode 00755
  action :create
  recursive true
  not_if { node[ 'cloudstack' ][ 'mgmt_ipaddr' ] == node[ 'cloudstack' ][ 'nfs_ipaddr' ] }
end

#
# mount storage NFS sharing (not_if mgmt == nfs)
#
mount node[ 'cloudstack' ][ 'nfs_root_dir' ] do
  device "#{node[ 'cloudstack' ][ 'nfs_ipaddr' ]}:#{node[ 'cloudstack' ][ 'nfs_root_dir' ]}"
  fstype 'nfs'
  not_if { node[ 'cloudstack' ][ 'mgmt_ipaddr' ] == node[ 'cloudstack' ][ 'nfs_ipaddr' ] }
end

#
# exec cloud-install-sys-tmplt
#
if version =~ /^4\.0\.\d$/
  sys_tmplt = '/usr/lib64/cloud/common/scripts/storage/secondary/cloud-install-sys-tmplt'
elsif version =~ /^[23]\.\d\.\d+$/
  sys_tmplt = '/usr/lib64/cloud/agent/scripts/storage/secondary/cloud-install-sys-tmplt'
end
execute 'cloud-install-sys-tmplt' do
  command "#{sys_tmplt} -m #{node[ 'cloudstack' ][ 'nfs_root_dir' ]}/#{node[ 'cloudstack' ][ 'nfs_secondary_dir' ]} -f #{node[ 'cloudstack' ][ 'nfs_root_dir' ]}/#{node[ 'cloudstack' ][ version ][ 'systemvm_filename' ]} -h kvm -F"
end

#
# umount storage NFS sharing (not_if mgmt == nfs)
#
mount node[ 'cloudstack' ][ 'nfs_root_dir' ] do
  action :umount
  not_if { node[ 'cloudstack' ][ 'mgmt_ipaddr' ] == node[ 'cloudstack' ][ 'nfs_ipaddr' ] }
end

#
# [EOF]
#
