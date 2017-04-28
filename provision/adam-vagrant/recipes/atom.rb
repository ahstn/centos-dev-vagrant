#
# Cookbook Name:: adam-vagrant
# Recipe:: atom
# Install and configure atom.io for Chef development
#

# TODO: Need tests for this recipe
yum_repository 'mosquito-atom' do
  description 'Copr repo for Atom.io owned by mosquito'
  baseurl node['atom']['repo']['url']
  gpgcheck true
  gpgkey node['atom']['repo']['gpgkey']
  skip_if_unavailable true
end

yum_package 'atom'

node['atom']['plugins'].each do |plugin|
  execute 'install-atom-plugin' do
    command "apm install #{plugin}"
    action :run
  end
end
