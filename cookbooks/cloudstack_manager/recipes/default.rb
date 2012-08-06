#
# Cookbook Name:: cloudstack_manager
# Recipe:: default
#

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
remote_file "/root/#{node[ :cloudstack_manager ][ :tarball_basename ]}.tar.gz" do
  source "#{node[ :cloudstack_manager ][ :tarball_base_uri ]}#{node[ :cloudstack_manager ][ :tarball_basename ]}.tar.gz"
  checksum "#{node[ :cloudstack_manager ][ :tarball_sha256 ]}"
  mode 0644
end

#
# unarchive CloudStack tarball
#
execute 'untar-cloudstack' do
  cwd '/root'
  command "tar xfz #{node[ :cloudstack_manager ][ :tarball_basename ]}.tar.gz"
end

#
# install CloudStack management server
#
execute 'install-cloudstack-management-server' do
  cwd "/root/#{node[ :cloudstack_manager ][ :tarball_basename ]}"
  command 'echo -e "M\ny" | ./install.sh'
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
# install CloudStack database server
#
execute 'install-cloudstack-management-server' do
  cwd "/root/#{node[ :cloudstack_manager ][ :tarball_basename ]}"
  command 'echo -e "D\ny" | ./install.sh'
end

#
# modify /etc/my.cnf and restart MySQL
#
template '/etc/my.cnf' do
  source 'my.cnf.erb'
  owner 'root'
  group 'root'
  mode 0644
end
service 'mysqld' do
  action :restart
end

#
# set MySQL root password
#
execute 'install-cloudstack-management-server' do
  command %Q%echo -e "SET PASSWORD = PASSWORD('#{node[ :cloudstack_manager ][ :mysql_root_pass ]}');\nexit\n" | mysql -u #{node[ :cloudstack_manager ][ :mysql_root_name ]}%
end

#
# exec cloud-setup-databases
#
execute 'exec-cloud-setup-databases' do
  command "cloud-setup-databases #{node[ :cloudstack_manager ][ :mysql_user_name ]}:#{node[ :cloudstack_manager ][ :mysql_user_pass ]}@localhost --deploy-as=#{node[ :cloudstack_manager ][ :mysql_root_name ]}:#{node[ :cloudstack_manager ][ :mysql_root_pass ]}"
end

#
# exec cloud-setup-management
#
execute 'exec-cloud-setup-management' do
  command 'cloud-setup-management'
end

#
# mkdir storage NFS sharing (primary)
#
execute 'mkdir-storage-nfs-sharing-primary' do
  command "mkdir -p #{node[ :cloudstack_manager ][ :nfs_root_dir ]}/#{node[ :cloudstack_manager ][ :nfs_primary_dir ]}"
end

#
# mkdir storage NFS sharing (secondary)
#
execute 'mkdir-storage-nfs-sharing-secondary' do
  command "mkdir -p #{node[ :cloudstack_manager ][ :nfs_root_dir ]}/#{node[ :cloudstack_manager ][ :nfs_secondary_dir ]}"
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
  source 'sysconfig/nfs.erb'
  owner 'root'
  group 'root'
  mode 0644
end

#
# modify /etc/sysconfig/iptables
#
template '/etc/sysconfig/iptables' do
  source 'sysconfig/iptables.erb'
  owner 'root'
  group 'root'
  mode 0600
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
# restart nfs
#
service 'nfs' do
  action :restart
end

#
# download system vm
#
remote_file "/root/#{node[ :cloudstack_manager ][ :systemvm_filename ]}" do
  source "#{node[ :cloudstack_manager ][ :systemvm_base_uri ]}#{node[ :cloudstack_manager ][ :systemvm_filename ]}"
  checksum "#{node[ :cloudstack_manager ][ :systemvm_sha256 ]}"
  mode 0644
end

#
# exec cloud-install-sys-tmplt
#
execute 'exec-cloud-install-sys-tmplt' do
  command "/usr/lib64/cloud/agent/scripts/storage/secondary/cloud-install-sys-tmplt -m #{node[ :cloudstack_manager ][ :nfs_root_dir ]}/#{node[ :cloudstack_manager ][ :nfs_secondary_dir ]} -f /root/#{node[ :cloudstack_manager ][ :systemvm_filename ]} -h kvm -F"
end

#
# [EOF]
#
