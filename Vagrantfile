ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'

Vagrant.configure("2") do |config|
  # Plugins
  config.vbguest.auto_update = true
  config.berkshelf.enabled = true
  config.berkshelf.berksfile_path = "chef/adam-vagrant/Berksfile"

  config.vm.box = "centos/7"
  config.vm.hostname = "centos"

  # https://www.vagrantup.com/docs/synced-folders/basic_usage.html
  # config.vm.synced_folder "~/git", "/git"
  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"

  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
    vb.memory = "1024"
  end

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "chef"
    chef.roles_path = "chef/role"
    chef.add_role("vagrant")
  end
end
