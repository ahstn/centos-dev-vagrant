#
# Cookbook Name:: adam-vagrant
# Recipe:: java
#

include_recipe 'java'

yum_package 'maven'

remote_file '/tmp/intellij.tar.gz' do
  source node['java']['intellij']['url']
  mode 0644
end

if node['vagrant']['vm_type'] == 'headed'
  directory node['java']['intellij']['dir'] do
    recursive true
  end

  execute 'tar --strip 1 -xf /tmp/intellij.tar.gz' do
    cwd node['java']['intellij']['dir']
  end

  template '/usr/share/applications/intellij-idea.desktop' do
    source 'intellij.desktop.erb'
    variables install_dir: node['java']['intellij']['dir']
  end
end
