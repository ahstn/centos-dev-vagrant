#
# Cookbook Name:: adam-vagrant
# Recipe:: docker
#

# TODO: Chef fails when this trys to start the docker service.
# TODO: Integration tests.

docker_service 'default' do
  host 'unix:///var/run/docker.sock'
  install_method 'auto'
  service_manager 'auto'
  action [:create]
end
