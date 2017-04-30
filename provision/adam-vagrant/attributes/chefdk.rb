# TODO: Investigate nokogiri issue when upgrading foodcritic
default['chefdk']['gem_sources'] = %w(https://rubygems.org http://rubygems.org)
default['chefdk']['gems'] = %w(kitchen-docker rubocop inspec)
