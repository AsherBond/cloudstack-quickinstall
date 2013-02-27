name             "cloudstack"
maintainer       "CREATIONLINE,INC."
maintainer_email "d-higuchi@creationline.com"
license          "Apache 2.0"
description      "Installs/Configures cloudstack"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.4.0"

supports 'centos'

depends 'selinux'
depends 'ntp'
depends 'yum'
