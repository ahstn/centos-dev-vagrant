ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'

Vagrant.configure('2') do |config|
  config.vbguest.auto_update = true

  config.vm.box = 'centos/7'
  config.vm.hostname = 'centos'
  config.vm.synced_folder '.', '/vagrant', type: 'virtualbox'

  config.vm.provider 'virtualbox' do |vb|
    vb.cpus = 2
    vb.memory = 1024
  end

  config.vm.provision 'ansible_local' do |ansible|
    ansible.install = true
    ansible.playbook = 'ansible/role.yml'
  end
end
