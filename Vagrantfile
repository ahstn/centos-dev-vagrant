# -*- mode: ruby -*-
# vi: set ft=ruby :

# We need Vagrant >= 2.1.0 becuse we use triggers
Vagrant.require_version '>= 2.1.0'

required_plugins = %w[vagrant-reload vagrant-persistent-storage vagrant-vbguest vagrant-proxyconf nugrant]
plugins_to_install = required_plugins.reject { |plugin| Vagrant.has_plugin? plugin }
unless plugins_to_install.empty?
  puts "Installing plugins: #{plugins_to_install.join(' ')}"
  if system "vagrant plugin install #{plugins_to_install.join(' ')}"
    exec "vagrant #{ARGV.join(' ')}"
  else
    abort 'Installation of one or more plugins has failed. Aborting.'
  end
end

vagrant_dir = __dir__

Vagrant.configure(2) do |config|
  config.vm.box = 'bento/fedora-29'

  # Unsupported audio config will cause VBox provisioning to fail.
  default_vb_audio = nil
  default_vb_audiocontroler = 'hda'
  if Vagrant::Util::Platform.windows?
    default_vb_audio  = 'dsound'
  elsif Vagrant::Util::Platform.platform =~ /darwin/
    default_vb_audio  = 'coreaudio'
    default_vb_audiocontroler = 'hda'
  end

  # .vagrantuser - extended provisioning configuration
  # See: https://github.com/maoueh/nugrant
  config.user.defaults = {
    'proxy' => {
      'enabled' => false,
      'http' => 'http://example.com:3128/',
      'https' => 'http://example.com:3128/',
      'ftp' => 'http://example.com:3128/',
      'no_proxy' => 'localhost,127.0.0.1'
    },
    'ansible' => {
      'skip_tags' => []
    },
    'java_license_declaration' => '',
    'java' => {
      'install_dir' => '/opt/java',
      'license_declaration' => ''
    },
    'maven' => {
      'install_dir' => '/opt/maven'
    },
    'timezone' => 'Europe/London',
    'locales' => {
      'default' => 'en_GB.UTF-8',
      'present' => ['en_GB.UTF-8', 'en_US.UTF-8']
    },
    'keyboard' => {
      'model' => 'pc105',
      'layout' => 'gb',
      'variant' => ''
    },
    'git_user' => {
      'name' => nil,
      'email' => nil,
      'force' => false
    },
    'virtualbox' => {
      'name' => 'development-environment',
      'gui' => true,
      'cpus' => 2,
      'vram' => '64',
      'accelerate3d' => 'off',
      'memory' => '4096',
      'clipboard' => 'bidirectional',
      'draganddrop' => 'bidirectional',
      'audio' => default_vb_audio,
      'audiocontroller' => default_vb_audiocontroler
    },
  }

  # Fail if Java is being installed and license hasn't been accepted.
  config.trigger.before [:up, :provision] do
    if (!config.user.ansible.skip_tags.include? 'java') && config.user.java.license_declaration != 'I accept the "Oracle Binary Code License Agreement for the Java SE Platform Products and JavaFX" under the terms at http://www.oracle.com/technetwork/java/javase/terms/license/index.html'
      abort "Aborting... to continue you must accept the Oracle Binary Code License Agreement\n(see https://github.com/gantsign/development-environment/wiki/Java-license-declaration)."
    end
  end

  # Update the VirtualBox Guest Additions
  config.vbguest.auto_update = true

  config.vm.provider 'virtualbox' do |vb|
    vb.name = config.user.virtualbox.name
    vb.gui = config.user.virtualbox.gui
    vb.cpus = config.user.virtualbox.cpus
    vb.memory = config.user.virtualbox.memory

    vb.customize ['modifyvm', :id, '--vram', config.user.virtualbox.vram]
    vb.customize ['modifyvm', :id, '--accelerate3d', config.user.virtualbox.accelerate3d]
    vb.customize ['modifyvm', :id, '--clipboard', config.user.virtualbox.clipboard]
    vb.customize ['modifyvm', :id, '--draganddrop', config.user.virtualbox.draganddrop]

    unless config.user.virtualbox.audio.nil?
      vb.customize ['modifyvm', :id, '--audio', config.user.virtualbox.audio, '--audiocontroller', config.user.virtualbox.audiocontroller]
    end
  end

  # Customfile - extended provider configuration
  # See: https://www.vagrantup.com/docs/providers/
  if File.exist?(File.join(vagrant_dir, 'Customfile'))
    eval(IO.read(File.join(vagrant_dir, 'Customfile')), binding)
  end

  if config.user.proxy.enabled
    config.proxy.enabled = config.user.proxy.enabled
    config.proxy.http = config.user.proxy.http
    config.proxy.https = config.user.proxy.https
    config.proxy.ftp = config.user.proxy.ftp
    config.proxy.no_proxy = config.user.proxy.no_proxy
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
    # Workaround for: "[ERROR]: failed to download the file: [Errno 104] Connection reset by peer"
    ansible.galaxy_command = 'alt-galaxy install --role-file=%{role_file} --roles-path=%{roles_path} --force'

    ansible.extra_vars = {
      java_license_declaration: config.user.java.license_declaration,
      java_install_dir: config.user.java.install_dir,
      maven_install_dir: config.user.maven.install_dir,
      timezone: config.user.timezone,
      locales_present: config.user.locales.present,
      locales_default: {
        lang: config.user.locales['default']
      },
      keyboard_model: config.user.keyboard.model,
      keyboard_layout: config.user.keyboard.layout,
      keyboard_variant: config.user.keyboard.variant,
      git_user_name: config.user.git_user.name,
      git_user_email: config.user.git_user.email,
      git_user_force: config.user.git_user.force,
    }
    ansible.skip_tags = config.user.ansible.skip_tags
    #ansible.verbose = "vvvv"
  end

  # Restart the VM after everything is installed
  config.vm.provision :reload
end
