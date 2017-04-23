name 'adam-vagrant'
maintainer 'Adam Houston'
maintainer_email 'phazyy9@gmail.com'
description 'Used for provisioning a Centos/Fedora dev VM'
license 'MIT'

issues_url 'https://github.com/phazyy/centos-dev-vagrant/issues' if respond_to?(:issues_url)
source_url 'https://github.com/chef-cookbooks/something' if respond_to?(:source_url)
chef_version '>= 12.5' if respond_to?(:chef_version)

supports 'redhat'
version '0.1.0'

depends 'chef-dk', '~> 3.1.0'
