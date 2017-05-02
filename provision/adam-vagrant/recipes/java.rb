#
# Cookbook Name:: adam-vagrant
# Recipe:: java
#

include_recipe 'java'

yum_package 'maven'

if node['vagrant']['vm_type'] == 'headed'
  directory node['intellij']['dir'] do
    recursive true
  end

  remote_file 'download_intellij' do
    path node['intellij']['package']
    source node['intellij']['url']
    mode 0644
    action :create_if_missing
    notifies :run, 'execute[unpack_intellij]', :immediately
  end

  execute 'unpack_intellij' do
    command "tar --strip 1 -xf #{node['intellij']['package']}"
    cwd node['intellij']['dir']
    action :nothing
  end

  template '/usr/share/applications/intellij-idea.desktop' do
    source 'intellij.desktop.erb'
    variables install_dir: node['intellij']['dir']
  end
end
