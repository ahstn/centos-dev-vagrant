require 'spec_helper'

describe 'adam-vagrant::common' do
  describe 'override run with headed vm_type' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node|
        node.override['vagrant']['user'] = 'adam'
        node.override['vagrant']['vm_type'] = 'headed'
      end.converge(described_recipe)
    end

    # TODO: yum group "GNOME Desktop"

    it 'installs expected yum package for terminator' do
      expect(chef_run).to install_yum_package('terminator')
    end

    it 'installs expected yum package for chromium' do
      expect(chef_run).to install_yum_package('chromium')
    end
  end

  describe 'default run with headless vm_type' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node|
        node.override['vagrant']['user'] = 'adam'
      end.converge(described_recipe)
    end

    it 'installs expected yum package for git' do
      expect(chef_run).to install_yum_package('git')
    end

    it 'installs expected yum package for mlocate' do
      expect(chef_run).to install_yum_package('mlocate')
    end

    it 'renders expected gitconfig template without user credentials' do
      gitconfig = "#{chef_run.node['vagrant']['home']}/.gitconfig"

      expect(chef_run).to render_file(gitconfig).with_content { |content|
        expect(content).to_not include('name = ChefSpec')
        expect(content).to_not include('email = spec@chef.io')
        expect(content).to include("name = \n")
        expect(content).to include("email = \n")
      }
    end

    it 'renders expected gitconfig template with user credentials' do
      chef_run.node.normal['git']['name'] = 'ChefSpec'
      chef_run.node.normal['git']['email'] = 'spec@chef.io'
      chef_run.converge(described_recipe)

      gitconfig = "#{chef_run.node['vagrant']['home']}/.gitconfig"

      expect(chef_run).to render_file(gitconfig).with_content { |content|
        expect(content).to include('name = ChefSpec')
        expect(content).to include('email = spec@chef.io')
      }
    end
  end
end
