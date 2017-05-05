default['intellij']['edition'] = 'C'
default['intellij']['version'] = '2017.1'
default['intellij']['domain'] = 'https://download.jetbrains.com/idea/'
default['intellij']['dir'] = '/opt/intellij-idea'
default['intellij']['path'] = '/usr/bin/intellij'
default['intellij']['package'] = '/tmp/intellij.tar.gz'

domain  = node['intellij']['domain']
edition = node['intellij']['edition']
version = node['intellij']['version']
default['intellij']['url'] = "#{domain}ideaI#{edition}-#{version}.tar.gz"
