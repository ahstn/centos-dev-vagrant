#
# Cookbook Name:: adam-vagrant
# Recipe:: common
#

# TODO: Make this an attribute
home = Dir.home(node['vagrant']['user'])

if node['dev_tools']['vm_type'] == 'headed'
  # As there's no yum_group, just execute group install instead
  execute 'yum group install -y "GNOME Desktop"'

  # Enable GUI on boot
  execute 'systemctl set-default graphical.target'

  yum_package 'terminator'
  yum_package 'chromium'
end

# Install our dev tools
yum_package 'git'
yum_package 'mlocate'

template "#{home}/.gitconfig" do
  source 'gitconfig.erb'
  owner node['vagrant']['user']
  group node['vagrant']['user']
  mode 0644
  action :create
  variables name: node['git']['name'],
            email: node['git']['email']
end
