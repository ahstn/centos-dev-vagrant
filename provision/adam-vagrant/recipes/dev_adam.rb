#
# Cookbook Name:: adam-vagrant
# Recipe:: dev_adam
# Install and configure my personal dev tools
#

home = Dir.home(node['vagrant']['user'])
shell = '/usr/bin/zsh'

yum_package 'zsh'

remote_file "#{home}/oh-my-zsh.sh" do
  source node['oh-my-zsh']['url']
  user node['vagrant']['user']
  mode 0755
  action :create_if_missing
end

execute 'oh-my-zsh.sh' do
  command "#{shell} #{home}/oh-my-zsh.sh"
  user node['vagrant']['user']
  action :run
  environment 'HOME' => home,
              'SHELL' => shell
end

template "#{home}/.zshrc" do
  source 'zshrc.erb'
  owner node['vagrant']['user']
  action :create
  variables theme: node['oh-my-zsh']['theme'],
            plugins: node['oh-my-zsh']['plugins']
end

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
