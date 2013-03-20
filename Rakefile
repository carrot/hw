#!/usr/bin/env rake
require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "cucumber/rake/task"

task :default => :spec

RSpec::Core::RakeTask.new
Cucumber::Rake::Task.new do |t|
  t.cucumber_opts = %w{--format pretty}
end
