#
# Cookbook Name:: adam-vagrant
# Recipe:: docker
#

# Starting docker in kitchen fails due to no loopback devices available
if node['vagrant']['user'] == 'kitchen'
  docker_installation 'default' do
    action :create
  end
else
  docker_service 'default' do
    host 'unix:///var/run/docker.sock'
    install_method 'auto'
    service_manager 'auto'
    action [:create, :start]
  end
end
