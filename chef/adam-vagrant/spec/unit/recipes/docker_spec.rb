require 'spec_helper'

describe 'adam-vagrant::docker' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
      node.override['vagrant']['user'] = ENV['USER'] || ENV['USERNAME']
    end.converge(described_recipe)
  end

  it 'executes the docker_service custom resouce as expected' do
    expect(chef_run).to create_docker_service('default')
    expect(chef_run).to start_docker_service('default')
  end
end
