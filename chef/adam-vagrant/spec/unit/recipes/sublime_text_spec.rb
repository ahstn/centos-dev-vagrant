require 'spec_helper'

describe 'adam-vagrant::sublime_text' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
      node.override['vagrant']['user'] = ENV['USER'] || ENV['USERNAME']
      node.override['vagrant']['vm_type'] = 'headed'
    end.converge(described_recipe)
  end

  context 'install sublime' do
    it 'creates the install folder' do
      expect(chef_run).to create_directory('/opt/sublime_text_3').with(
        owner: 'root',
        group: 'root'
      )
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

    it 'renders sublime.desktop template file' do
      desktop_file = '/usr/share/applications/sublime-text-3.desktop'
      dir = '/opt/sublime_text_3'
      expect(chef_run).to render_file(desktop_file).with_content { |content|
        expect(content).to include("Exec=#{dir}/sublime_text")
        expect(content).to include("Icon=#{dir}/Icon/128x128/sublime-text.png")
      }
    end

  end

  context 'install package control' do
    it 'creates the sublime text packages folder' do
      dir = chef_run.node['sublime']['pc']['dir']

      expect(chef_run).to create_directory(dir).with(
        owner: 'adam',
        group: 'adam'
      )
    end

    it 'downloads package control if missing' do
      resource = 'install_package_control'
      expect(chef_run).to create_remote_file_if_missing(resource).with(
        owner: 'adam',
        group: 'adam'
      )
    end
  end
end
