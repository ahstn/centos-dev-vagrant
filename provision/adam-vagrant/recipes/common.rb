#
# Cookbook Name:: adam-vagrant
# Recipe:: common
#

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
