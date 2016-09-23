source ENV['GEM_SOURCE'] || 'https://rubygems.org'

puppetversion = ENV.key?('PUPPET_VERSION') ? ENV['PUPPET_VERSION'] : ['>= 3.7']

group :development, :unit_tests do
  gem 'puppet', puppetversion
  gem 'puppetlabs_spec_helper', '>= 1.0.0'
  gem 'puppet-lint', '>= 1.0.0'
  gem 'facter', '>= 1.7.0'
  gem 'rspec-puppet'
  gem 'rspec_junit_formatter'
  gem 'rgen'
end

group :system_tests, optional: true do
  gem 'beaker'
  gem 'beaker-rspec'
end
