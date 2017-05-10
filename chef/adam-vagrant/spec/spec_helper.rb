require 'chefspec'
require 'chefspec/berkshelf'

at_exit { ChefSpec::Coverage.report! }

RSpec.configure do |config|
  config.platform = 'centos'
  config.version = '7.2.1511'
end
