#
# Cookbook Name:: adam-vagrant
# Recipe:: dev_adam
# Install and configure my personal dev tools
#

home = Dir.home('vagrant')
shell = '/usr/bin/zsh'

yum_package 'zsh'

remote_file "#{home}/oh-my-zsh.sh" do
  source node['oh-my-zsh']['url']
  user 'vagrant'
  mode 0755
  action :create_if_missing
end

execute 'oh-my-zsh.sh' do
  command "#{shell} #{home}/oh-my-zsh.sh"
  user 'vagrant'
  action :run
  environment 'HOME' => home,
              'SHELL' => shell
end

template "#{home}/.zshrc" do
  source 'zshrc.erb'
  owner 'vagrant'
  action :create
  variables theme: node['oh-my-zsh']['theme'],
            plugins: node['oh-my-zsh']['plugins']
end

yum_package 'vim'

directory "#{home}/.vim/autoload" do
  recursive true
  owner 'vagrant'
  mode 0755
end

remote_file "#{home}/.vim/autoload/plug.vim" do
  source node['vim-plug']['url']
  mode 0755
  action :create_if_missing
end
