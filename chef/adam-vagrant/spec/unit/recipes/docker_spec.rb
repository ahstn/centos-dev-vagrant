require 'spec_helper'
require 'matchers_helper'

describe 'adam-vagrant::docker' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
      node.override['vagrant']['user'] = ENV['USER'] || ENV['USERNAME']
    end.converge(described_recipe)
  end

  it 'executes the docker_service custom resouce as expected' do
    expect(chef_run).to install_docker_service('default')
  end
end
