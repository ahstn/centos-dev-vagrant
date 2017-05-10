default['vagrant']['vm_type'] = 'headed'
default['vagrant']['user'] = 'vagrant'
default['vagrant']['home'] = Dir.home(node['vagrant']['user'])

default['git']['name'] = ''
default['git']['email'] = ''
