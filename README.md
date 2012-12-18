Description
===========

CloudStack quick installer using Chef Solo.

Requirements
============

* CentOS 6.2 (x86\_64)

Attributes
==========

version setting
---------------

* `node[ 'cloudstack' ][ 'version' ]` - CloudStack version (3.0.4 or 2.2.14)

network settings
----------------

* `node[ 'cloudstack' ][ 'mgmt_ipaddr'   ]` - Management server IP address
* `node[ 'cloudstack' ][ 'mgmt_fqdn'     ]` - Management server FQDN
* `node[ 'cloudstack' ][ 'mgmt_hostname' ]` - Management server hostname
* `node[ 'cloudstack' ][ 'nfs_ipaddr'    ]` - NFS server IP address (it's ok same as Management server)
* `node[ 'cloudstack' ][ 'nfs_fqdn'      ]` - NFS server FQDN (it's ok same as Management server)
* `node[ 'cloudstack' ][ 'nfs_hostname'  ]` - NFS server hostname (it's ok same as Management server)
* `node[ 'cloudstack' ][ 'host_ipaddr'   ]` - Host server IP address
* `node[ 'cloudstack' ][ 'host_fqdn'     ]` - Host server FQDN
* `node[ 'cloudstack' ][ 'host_hostname' ]` - Host server hostname
* `node[ 'cloudstack' ][ 'domainname'    ]` - Servers domainname

MySQL settings
--------------

* `node[ 'cloudstack' ][ 'mysql_root_name' ]` - MySQL root username
* `node[ 'cloudstack' ][ 'mysql_root_pass' ]` - MySQL root password
* `node[ 'cloudstack' ][ 'mysql_user_name' ]` - MySQL CloudStack username
* `node[ 'cloudstack' ][ 'mysql_user_pass' ]` - MySQL CloudStack password

NFS settings
------------

* `node[ 'cloudstack' ][ 'nfs_root_dir'      ]` - NFS root directory
* `node[ 'cloudstack' ][ 'nfs_primary_dir'   ]` - Primary Storage directory name
* `node[ 'cloudstack' ][ 'nfs_secondary_dir' ]` - Secondary Storage directory name

Usage
=====

     # cat cs-mgmt.json
     {
	"cloudstack": {
		"version":		"3.0.4",
		"mgmt_ipaddr":		"192.168.26.110",
		"mgmt_fqdn":		"cs-manager.example.jp",
		"mgmt_hostname":	"cs-manager",
		"nfs_ipaddr":		"192.168.26.111",
		"nfs_fqdn":		"cs-nfs.example.jp",
		"nfs_hostname":		"cs-nfs",
		"host_ipaddr":		"192.168.26.112",
		"host_fqdn":		"cs-host.example.jp",
		"host_hostname":	"cs-host",
		"domainname":		"example.jp"
	},
	"run_list": [ "recipe[cloudstack-quickinstall::manager]" ]
     }
     # chef-solo -c chef-solo -j cs-mgmt.json


License and Author
==================

* Author:: HIGUCHI Daisuke <d-higuchi@creationline.com>

* Copyright:: 2012, CREATIONLINE,INC.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
