require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'bundler'

#require File.expand_path('lib/tasks/acts_as_flying_saucer.rake')
Bundler::GemHelper.install_tasks
desc 'Default: run unit tests.'
task :default => :test

desc 'Test the nailgun plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the nailgun plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Nailgun'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
