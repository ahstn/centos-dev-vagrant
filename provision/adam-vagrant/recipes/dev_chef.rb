#
# Cookbook Name:: adam-vagrant
# Recipe:: dev_chef
#

chef_dk 'default' do
  global_shell_init true
  action :install
end

# TODO: Add custom gemrc
