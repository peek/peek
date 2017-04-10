require 'bundler/gem_tasks'
require 'rake/testtask'

desc 'Default: run tests'
task default: :test

desc 'Run Peek tests.'
Rake::TestTask.new do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
end
