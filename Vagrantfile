ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'

Vagrant.configure("2") do |config|
  if Vagrant.has_plugin?('vagrant-vbguest')
    config.vbguest.auto_update = true
  end

  config.vm.box = "centos/7"
  config.vm.hostname = "centos"

  # https://www.vagrantup.com/docs/synced-folders/basic_usage.html
  # config.vm.synced_folder "~/git", "/git"
  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"

  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
    vb.customize ["modifyvm", :id, "--cpuexecutioncap", "70"]
    vb.customize ["modifyvm", :id, "--cpus", "2"]
    vb.customize ["modifyvm", :id, "--memory", "4096"]
    vb.customize ["modifyvm", :id, "--rtcuseutc", "on"]
  end

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["chef", "chef/adam-vagrant/vendor"]
    chef.roles_path = "chef/role"
    chef.add_role("vagrant")
  end
end
