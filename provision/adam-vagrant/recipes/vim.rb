#
# Cookbook Name:: adam-vagrant
# Recipe:: vim
#

yum_package 'vim-enhanced'

directory "#{node['vagrant']['home']}/.vim/autoload" do
  recursive true
  owner node['vagrant']['user']
  group node['vagrant']['user']
  mode 0755
end

remote_file "#{node['vagrant']['home']}/.vim/autoload/plug.vim" do
  source node['vim-plug']['url']
  owner node['vagrant']['user']
  group node['vagrant']['user']
  mode 0755
  action :create_if_missing
end
