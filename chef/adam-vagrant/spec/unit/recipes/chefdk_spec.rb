require 'spec_helper'

describe 'adam-vagrant::chefdk' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
      node.override['vagrant']['user'] = ENV['USER'] || ENV['USERNAME']
    end.converge(described_recipe)
  end

  it 'includes docker recipe if gems include kitchen-docker' do
    expect(chef_run).to include_recipe('adam-vagrant::docker')
  end

  it 'skips the docker recipe if gems do not include kitchen-docker' do
    chef_run.node.normal['chefdk']['gems'] = %w(rubocop inspec)
    chef_run.converge(described_recipe)

    expect(chef_run).to_not include_recipe('adam-vagrant::docker')
  end

  it 'executes the chefdk custom resouce as expected' do
    expect(chef_run).to install_chef_dk('default')
  end

  it 'upgrades the expected chef gems' do
    %w(kitchen-docker rubocop inspec).each do |gem|
      expect(chef_run).to upgrade_chef_gem(gem)
    end
  end

  it 'renders the gemrc template for vagrant and root' do
    %w(/home/adam/.gemrc /root/.gemrc).each do |file|
      expect(chef_run).to render_file(file).with_content { |content|
        expect(content).to include('- https://rubygems.org')
        expect(content).to include('- http://rubygems.org')
      }
    end
  end
end
