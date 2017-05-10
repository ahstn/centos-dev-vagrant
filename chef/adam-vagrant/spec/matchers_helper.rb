if defined?(ChefSpec)
  ChefSpec::Runner.define_runner_method(:chef_dk)

  def install_chef_dk(resource)
    ChefSpec::Matchers::ResourceMatcher.new(:chef_dk, :create, resource)
  end
end
