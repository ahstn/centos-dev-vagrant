#
# Cookbook Name:: adam-vagrant
# Recipe:: zsh
#

home = Dir.home(node['vagrant']['user'])
shell = '/usr/bin/zsh'

yum_package 'zsh'

remote_file "#{home}/oh-my-zsh.sh" do
  source node['oh-my-zsh']['url']
  owner node['vagrant']['user']
  group node['vagrant']['user']
  mode 0644
  action :create_if_missing
end

execute 'oh-my-zsh.sh' do
  command "#{shell} #{home}/oh-my-zsh.sh"
  user node['vagrant']['user']
  group node['vagrant']['user']
  action :run
  environment 'HOME' => home,
              'SHELL' => shell
end

template "#{home}/.zshrc" do
  source 'zshrc.erb'
  owner node['vagrant']['user']
  group node['vagrant']['user']
  mode 0644
  action :create
  variables theme: node['oh-my-zsh']['theme'],
            plugins: node['oh-my-zsh']['plugins']
end
