#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'cucumber/rake/task'

task :default => :cucumber

Cucumber::Rake::Task.new do |t|
  t.cucumber_opts = %w{--format pretty}
end
