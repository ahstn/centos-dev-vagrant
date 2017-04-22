#
# Cookbook Name:: adam-vagrant
# Recipe:: yum_repos
#

# Extra Packages for Enterprise Linux Repo
yum_package 'epel-release' do
  action :upgrade
end
