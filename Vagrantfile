# -*- mode: ruby -*-
# vi: set ft=ruby :

require_relative 'lib/vagrant'

Vagrant.require_version '>= 2.1.0' # Required for triggers
Vagrant.configure(2) do |config|
  config.vm.box = 'bento/fedora-29'

  # Forwarded port mapping which allows access to a specific exposed service.
  # config.vm.network 'forwarded_port', guest: 80, host: 8080

  # Private network to allow host-only access using a specific IP.
  # config.vm.network 'private_network', ip: '192.168.33.10'

  # Share an additional folder to the guest VM. ($host_dir, $guest_dir)
  # config.vm.synced_folder '../data', '/vagrant_data'

  # Update the VirtualBox Guest Additions
  config.vbguest.auto_update = true

  # Fail if Java is being installed and license hasn't been accepted.
  config.trigger.before [:up, :provision] do
    config_existance_check("#{__dir__}/.vagrantuser")
    java_license_check(config.user)
  end

  config.vm.provider 'virtualbox' do |vb|
    vb.name = config.user['virtualbox']['name']
    vb.gui = config.user['virtualbox']['gui']
    vb.cpus = config.user['virtualbox']['cpus']
    vb.memory = config.user['virtualbox']['memory']

    vb.customize ['modifyvm', :id, '--vram', config.user['virtualbox']['vram']]
    vb.customize ['modifyvm', :id, '--accelerate3d', config.user['virtualbox']['accelerate3d']]
    vb.customize ['modifyvm', :id, '--clipboard', config.user['virtualbox']['clipboard']]
    vb.customize ['modifyvm', :id, '--draganddrop', config.user['virtualbox']['draganddrop']]
  end

  if config.user['proxy']['enabled']
    config.proxy.enabled  = config.user['proxy']['enabled']
    config.proxy.http     = config.user['proxy']['http']
    config.proxy.https    = config.user['proxy']['https']
    config.proxy.ftp      = config.user['proxy']['ftp']
    config.proxy.no_proxy = config.user['proxy']['no_proxy']
  end

  # Perform preliminary setup before the main Ansible provisioning
  config.vm.provision 'ansible_local' do |ansible|
    ansible.playbook = 'provisioning/init.yml'
    ansible.extra_vars = { ansible_python_interpreter: '/usr/bin/python3' }
  end

  # Run Ansible from the Vagrant VM
  config.vm.provision 'ansible_local' do |ansible|
    ansible.playbook = 'provisioning/playbook.yml'
    ansible.extra_vars = { ansible_python_interpreter: '/usr/bin/python3' }
    ansible.galaxy_role_file = 'provisioning/requirements.yml'

    # Use alt-galaxy to download roles instead of ansible-galaxy.
    ansible.galaxy_command = 'alt-galaxy install --role-file=%{role_file} --roles-path=%{roles_path} --force'

    ansible.extra_vars = {
      java_license_declaration: config.user['java']['license_declaration'],
      java_install_dir: config.user['java']['install_dir'],
      java_version: config.user['java']['version'],
      maven_install_dir: config.user['maven']['install_dir'],
      maven_version: config.user['maven']['version'],
      timezone: config.user['timezone'],
      locales_present: config.user['locales']['present'],
      locales_default: {
        lang: config.user['locales']['default']
      },
      keyboard_model: config.user['keyboard']['model'],
      keyboard_layout: config.user['keyboard']['layout'],
      keyboard_variant: config.user['keyboard']['variant'],
      git_user_name: config.user['git_user']['name'],
      git_user_email: config.user['git_user']['email'],
      git_user_force: config.user['git_user']['force'],
    }
    ansible.skip_tags = config.user['ansible']['skip_tags']
    #ansible.verbose = "vvvv"
  end

  # Restart the VM after everything is installed
  config.vm.provision :reload
end
