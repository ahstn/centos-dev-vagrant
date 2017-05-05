require 'spec_helper'

describe 'adam-vagrant::sublime_text' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
      node.override['vagrant']['user'] = 'adam'
      node.override['vagrant']['vm_type'] = 'headed'
    end.converge(described_recipe)
  end

  context 'install sublime' do
    it 'creates the install folder' do
      expect(chef_run).to create_directory('/opt/sublime_text_3')
    end

    it 'downloads the install package if missing' do
      file = '/tmp/sublime_text.tar.bz2'
      expect(chef_run).to create_remote_file_if_missing(file)
      expect(chef_run.remote_file('download_sublime'))
        .to notify('execute[unpack_sublime]').to(:run)
    end

    it 'does not unpack the sublime archive by default' do
      expect(chef_run.execute('unpack_sublime')).to do_nothing
    end

    it 'does not symlink the sublime binary by default' do
      expect(chef_run.execute('symlink_sublime_binary')).to do_nothing
    end

    it 'renders intellij.desktop template file' do
      desktop_file = '/usr/share/applications/sublime-text-3.desktop'
      expect(chef_run).to render_file(desktop_file).with_content { |content|
        expect(content).to include('Exec=/opt/sublime_text_3/sublime_text')
        expect(content).to include('Icon=/opt/sublime_text_3/Icon/128x128/sublime-text.png')
      }
    end
  end
end
