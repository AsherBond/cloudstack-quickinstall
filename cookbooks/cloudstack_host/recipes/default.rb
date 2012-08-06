#
# Cookbook Name:: cloudstack_host
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

if node[ :cloudstack_host ][ :epel_release_rpm ] != ''
  #
  # download EPEL repos rpm
  #
  remote_file "/root/#{node[ :cloudstack_host ][ :epel_release_rpm ]}" do
    source "#{node[ :cloudstack_host ][ :epel_release_uri ]}#{node[ :cloudstack_host ][ :epel_release_rpm ]}"
    checksum "#{node[ :cloudstack_host ][ :epel_release_sha256 ]}"
    mode 0644
  end

  #
  # install EPEL repos rpm
  #
  package "epel-release" do
    action :install
    source "/root/#{node[ :cloudstack_host ][ :epel_release_rpm ]}"
  end
end

#
# download CloudStack tarball
#
remote_file "/root/#{node[ :cloudstack_host ][ :tarball_basename ]}.tar.gz" do
  source "#{node[ :cloudstack_host ][ :tarball_base_uri ]}#{node[ :cloudstack_host ][ :tarball_basename ]}.tar.gz"
  checksum "#{node[ :cloudstack_host ][ :tarball_sha256 ]}"
  mode 0644
end

#
# unarchive CloudStack tarball
#
execute 'untar-cloudstack' do
  cwd '/root'
  command "tar xfz #{node[ :cloudstack_host ][ :tarball_basename ]}.tar.gz"
end

#
# install CloudStack host agent
#
execute 'install-cloudstack-host-agent' do
  cwd "/root/#{node[ :cloudstack_host ][ :tarball_basename ]}"
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
  source 'libvirt/qemu.conf.erb'
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
# install ntp rpm
#
package "ntp" do
  action :install
end

#
# enable and start ntpd
#
service 'ntpd' do
  action [ :enable, :start ]
end

#
# [EOF]
#
