#
# Cookbook Name:: adam-vagrant
# Recipe:: dev_chef
#

# TODO: Add an attribute for user (this'll fail in kitchen runs)
home = Dir.home(node['vagrant']['user'])

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

template "#{home}/.gemrc" do
  source 'gemrc.erb'
  owner node['vagrant']['user']
  mode 0755
  variables sources: node['dev_chef']['gem_sources']
end
