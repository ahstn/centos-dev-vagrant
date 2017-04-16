#
# Cookbook: adam-vagrant
# Recipe: dev_tools
#

# As there's no yum_group, just execute group install instead
execute 'yum group install -y "GNOME Desktop"'

# Enable GUI on boot
execute 'systemctl set-default graphical.target'

# Install our dev tools
yum_package 'terminator'
yum_package 'git'
yum_package 'vim'
yum_package 'zsh'
yum_package 'chromium'
