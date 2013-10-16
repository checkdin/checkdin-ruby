# encoding: utf-8

require "bundler/gem_tasks"
Bundler.setup

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :default => :spec

namespace :ci do
  desc "Prepare fresh environment for a specrun"
  task 'setup' => [
    'spec/credentials.yml',
    :rspec_runtime_config,
  ]

  rule '.yml' => ['.yml.example'] do |t|
    cp t.source, t.name
  end

  task :rspec_runtime_config do
    rspec_config = <<-FORMAT
    --order random
    --color
    --format documentation
    --backtrace
    --profile
    FORMAT

    File.open('.rspec', 'w') do |f|
      f.write(rspec_config)
    end
  end
end

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  require 'checkdin/version'
  version = Checkdin::VERSION

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "checkdin #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
