#
# Cookbook Name:: adam-vagrant
# Recipe:: chefdk
#

if (node['chefdk']['gems'] & %w(kitchen-docker kitchen-dokken)).any?
  include_recipe 'adam-vagrant::docker'
end

chef_dk 'default' do
  global_shell_init true
  action :install
end

node['chefdk']['gems'].each do |package|
  chef_gem package do
    compile_time false
    action :upgrade
  end
end

print(node['vagrant']['user'])
%W(#{node['vagrant']['user']} root).each do |user|
  home = Dir.home(user)

  template "#{home}/.gemrc" do
    source 'gemrc.erb'
    owner user
    group user
    mode 0755
    variables sources: node['chefdk']['gem_sources']
  end
end
