#
# Cookbook Name:: adam-vagrant
# Recipe:: vim
#

# TODO: Tests for this recipe
yum_package 'vim'

directory "#{home}/.vim/autoload" do
  recursive true
  owner node['vagrant']['user']
  mode 0755
end

remote_file "#{home}/.vim/autoload/plug.vim" do
  source node['vim-plug']['url']
  mode 0755
  action :create_if_missing
end
