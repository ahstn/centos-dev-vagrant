#
# Cookbook Name:: adam-vagrant
# Recipe:: dev_chef
#

chef_dk 'default' do
  global_shell_init true
  action :install
end

node['dev_chef']['gems'].each do |package|
  chef_gem package do
    compile_time false
    action :upgrade
  end
end

# TODO: Add custom gemrc
