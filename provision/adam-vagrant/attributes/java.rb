default['java']['intellij']['edition'] = 'C'
default['java']['intellij']['version'] = '2017.1'
default['java']['intellij']['domain'] = 'https://download.jetbrains.com/idea/'
default['java']['intellij']['dir'] = '/usr/bin/intellij'

domain  = node['java']['intellij']['domain']
edition = node['java']['intellij']['edition']
version = node['java']['intellij']['version']
default['java']['intellij']['url'] = "#{domain}ideaI#{edition}-#{version}.tar.gz"
