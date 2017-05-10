#
# Cookbook Name:: adam-vagrant
# Recipes:: sublime_text
#

if node['vagrant']['vm_type'] == 'headed'
  directory node['sublime']['dir'] do
    recursive true
    user 'root'
    group 'root'
    mode 0775
  end

  remote_file 'download_sublime' do
    path node['sublime']['archive']
    source node['sublime']['url']
    mode 0644
    action :create_if_missing
    notifies :run, 'execute[unpack_sublime]', :immediately
  end

  execute 'unpack_sublime' do
    command "tar --strip 1 -xf #{node['sublime']['archive']}"
    cwd node['sublime']['dir']
    action :nothing
    notifies :run, 'execute[symlink_sublime_binary]', :immediately
  end

  execute 'symlink_sublime_binary' do
    command "ln -s sublime_text #{node['sublime']['path']}"
    cwd node['sublime']['dir']
    action :nothing
  end

  template '/usr/share/applications/sublime-text-3.desktop' do
    source 'sublime-text-3.desktop.erb'
    variables install_dir: node['sublime']['dir']
    owner 'root'
    group 'root'
    mode 0644
  end

  directory node['sublime']['pc']['dir'] do
    recursive true
    user node['vagrant']['user']
    group node['vagrant']['user']
    mode 0755
  end

  remote_file 'install_package_control' do
    path node['sublime']['pc']['path']
    source node['sublime']['pc']['url']
    user node['vagrant']['user']
    group node['vagrant']['user']
    mode 0755
    action :create_if_missing
  end
end
