Description
===========

CloudStack installer using Chef.

Requirements
============

* CentOS 6.2 (x86\_64)

Environments
============

CloudStack version (4.0.1 or 3.0.6 or 2.2.14)

network settings
----------------

* `mgmt_ipaddr  ` - Management server IP address
* `mgmt_fqdn    ` - Management server FQDN
* `mgmt_hostname` - Management server hostname
* `nfs_ipaddr   ` - NFS server IP address (it's ok same as Management server)
* `nfs_fqdn     ` - NFS server FQDN (it's ok same as Management server)
* `nfs_hostname ` - NFS server hostname (it's ok same as Management server)
* `host_ipaddr  ` - Host server IP address
* `host_fqdn    ` - Host server FQDN
* `host_hostname` - Host server hostname
* `domainname   ` - Servers domainname

MySQL settings
--------------

* `mysql_root_name` - MySQL root username
* `mysql_root_pass` - MySQL root password
* `mysql_user_name` - MySQL CloudStack username
* `mysql_user_pass` - MySQL CloudStack password

NFS settings
------------

* `nfs_root_dir     ` - NFS root directory
* `nfs_primary_dir  ` - Primary Storage directory name
* `nfs_secondary_dir` - Secondary Storage directory name

Notice
======

Please reboot servers after install successfully.

License and Author
==================

* Author:: HIGUCHI Daisuke <d-higuchi@creationline.com>

* Copyright:: 2012-2013, CREATIONLINE,INC.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
