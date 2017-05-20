if defined?(ChefSpec)
  ChefSpec::Runner.define_runner_method(:chef_dk)
  ChefSpec::Runner.define_runner_method(:docker_service)

  def install_chef_dk(resource)
    ChefSpec::Matchers::ResourceMatcher.new(:chef_dk, :create, resource)
  end

  def install_docker_service(resource)
    ChefSpec::Matchers::ResourceMatcher.new(:docker_service, :create, resource)
  end
end
