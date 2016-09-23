require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'

PuppetLint.configuration.send('disable_80chars')
PuppetLint.configuration.relative = true
PuppetLint.configuration.ignore_paths = [
  'pkg/**/*.pp',
  'spec/**/*.pp',
  'vendor/**/*.pp',
]

desc 'Validate manifests, templates, and ruby files'
task :validate do
  sh "puppet parser validate --noop #{'--parser future' if ENV['FUTURE_PARSER'] == 'yes'} #{Dir['manifests/**/*.pp'].join(' ')}"
  Dir['spec/**/*.rb', 'lib/**/*.rb'].each do |ruby_file|
    sh "ruby -c #{ruby_file}" unless ruby_file =~ %r{spec/fixtures}
  end
  Dir['templates/**/*.erb'].each do |template|
    sh "erb -P -x -T '-' #{template} | ruby -c"
  end
end

desc 'Run metadata_lint, lint, validate, and spec tests.'
task :test do
  [:lint, :validate, :spec].each do |test|
    Rake::Task[test].invoke
  end
end
