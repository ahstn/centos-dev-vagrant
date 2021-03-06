require 'spec_helper'

describe 'adam-vagrant::java' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
      node.override['vagrant']['user'] = ENV['USER'] || ENV['USERNAME']
      node.override['vagrant']['vm_type'] = 'headed'
    end.converge(described_recipe)
  end

  it 'runs expected recipe to install java' do
    expect(chef_run).to include_recipe('java')
  end

  it 'installs expected yum package for maven' do
    expect(chef_run).to install_yum_package('maven')
  end

  context 'install intellij' do
    it 'creates the install folder' do
      expect(chef_run).to create_directory('/opt/intellij-idea').with(
        owner: 'root',
        group: 'root'
      )
    end

    it 'downloads the install package if missing' do
      expect(chef_run).to create_remote_file_if_missing('/tmp/intellij.tar.gz')
      expect(chef_run.remote_file('download_intellij'))
        .to notify('execute[unpack_intellij]').to(:run)
    end

    it 'execute command does nothing by default' do
      expect(chef_run.execute('unpack_intellij')).to do_nothing
    end

    it 'does not symlink the sublime binary by default' do
      expect(chef_run.execute('symlink_intellij_binary')).to do_nothing
    end

    it 'renders intellij.desktop template file' do
      desktop_file = '/usr/share/applications/intellij-idea.desktop'
      expect(chef_run).to render_file(desktop_file).with_content { |content|
        expect(content).to include('Exec=/opt/intellij-idea/bin/idea.sh')
        expect(content).to include('Icon=/opt/intellij-idea/bin/idea.png')
      }
    end
  end
end
