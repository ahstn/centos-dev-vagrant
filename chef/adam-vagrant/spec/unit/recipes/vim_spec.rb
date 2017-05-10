require 'spec_helper'

describe 'adam-vagrant::vim' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
      node.override['vagrant']['user'] = ENV['USER'] || ENV['USERNAME']
      node.override['vim-plug']['url'] = 'https://repo.adam/plug.vim'
    end.converge(described_recipe)
  end

  it 'installs vim-enhanced package as expected' do
    expect(chef_run).to install_yum_package('vim-enhanced')
  end

  it 'creates directory for vim-plug' do
    expect(chef_run).to create_directory('/home/adam/.vim/autoload').with(
      owner: 'adam',
      group: 'adam'
    )
  end

  it 'downloads remote_file plug.vim as expected' do
    file = '/home/adam/.vim/autoload/plug.vim'
    expect(chef_run).to create_remote_file_if_missing(file).with(
      source: 'https://repo.adam/plug.vim',
      owner: 'adam',
      group: 'adam'
    )
  end
end
