require 'bundler/gem_tasks'

require 'rake/testtask'

Rake::TestTask.new( 'test:functional' ) do |t|
  t.libs += ['test', 'lib']
  t.pattern = FileList['test/functional/**/*_test.rb']
  t.verbose = true
end

Rake::TestTask.new( 'test:acceptance' ) do |t|
  t.libs += ['test', 'lib']
  t.pattern = FileList['test/acceptance/**/*_test.rb']
  t.verbose = true
end

desc 'Run all tests'
task :test => ['test:functional', 'test:acceptance']

task :default => :test
