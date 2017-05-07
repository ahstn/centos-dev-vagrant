require 'spec_helper'

describe 'adam-vagrant::zsh' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
      node.override['vagrant']['user'] = 'adam'
    end.converge(described_recipe)
  end

  it 'installs zsh package as expected' do
    expect(chef_run).to install_yum_package('zsh')
  end

  it 'executes oh-my-zsh install script as expected' do
    expect(chef_run).to run_execute('oh-my-zsh.sh').with(
      command: '/usr/bin/zsh /home/adam/oh-my-zsh.sh',
      user: 'adam'
    )
  end

  it 'creates the .zshrc template as expected' do
    file = '/home/adam/.zshrc'
    expect(chef_run).to create_template(file).with(
      owner: 'adam',
      group: 'adam',
      variables: {
        theme: 'robbyrussell',
        plugins: ['git', 'knife', 'sudo', 'systemd']
      }
    )
  end
end
