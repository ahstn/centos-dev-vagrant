#
# Cookbook Name:: adam-vagrant
# Recipe:: dev_chef
#

remote_file node['dev_chef']['local_path'] do
  source node['dev_chef']['url']
end

rpm_package node['dev_chef']['local_path']

# TODO: Add custom gemrc
