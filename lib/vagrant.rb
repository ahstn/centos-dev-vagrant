require 'yaml'

# Cross-plaform audio support (misconfiguration can cause provisioning to fail).
def configure_virtualbox_audio()
  audio = nil
  audiocontroller = 'hda'

  if Vagrant::Util::Platform.windows?
    audio  = 'dsound'
  elsif Vagrant::Util::Platform.platform =~ /darwin/
    audio  = 'coreaudio'
  end

  return audio, audiocontroller
end

# Check that the config file `.vagrantuser` exists.
def config_existance_check(path)
  unless File.exist? path
    raise_message 'Config file `.vagrantuser` not found, have you created it?'\
      "\nFor more information see the #Getting-Started section in the README.md"
  end
end

# Check for Orcacle license acceptance, otherwise abort.
def java_license_check(config)
  agreement = 'I accept the "Oracle Binary Code License Agreement under the terms at http://www.oracle.com/technetwork/java/javase/terms/license/index.html'
  unless config['ansible']['skip_tags'].include? 'java'
    if config['java']['license_declaration'] != agreement
      raise_message 'Aborting... to continue you must accept the Oracle License Agreement'
    end
  end
end

# Abort and print custom error message.
def raise_message(msg)
  raise Vagrant::Errors::VagrantError.new, msg
end

# Check plugins are installed, if not attempt to install them.
def ensure_plugins(plugins)
  logger = Vagrant::UI::Colored.new
  installed = false

  plugins.each do |plugin|
    plugin_name = plugin['name']
    manager = Vagrant::Plugin::Manager.instance

    next if manager.installed_plugins.key?(plugin_name)

    logger.warn("Installing plugin #{plugin_name}")

    manager.install_plugin(
      plugin_name,
      sources: plugin.fetch('source', %w[https://rubygems.org/ https://gems.hashicorp.com/]),
      version: plugin['version']
    )

    installed = true
  end

  return unless installed

  logger.warn('`vagrant up` must be re-run now that plugins are installed')
  exit
end

# Return a default post_up_message.
def get_default_post_up_message(vconfig)
  'Your Drupal VM Vagrant box is ready to use!'\
    "\n* You can run `vagrant ssh` to access a shell inside the VM"
    "\n* To safely stop the VM, run `vagrant halt`"
end
