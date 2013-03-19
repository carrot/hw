require 'fileutils'
include FileUtils

Given /^pending/ do
  pending
end

Given /^I haven't installed Hemingway before$/ do
  rm_rf File.expand_path("~/.hw")
end

# Useful for debugging timing problems
When /^sleep (\d+)$/ do |time|
  sleep time.to_i
end

When /^I set env variable "(\w+)" to "([^"]*)"$/ do |var, value|
  ENV[var] = value
end

Then /^"(.*?)" should be created$/ do |file|
  file_exists = File.exist?( File.expand_path(file) )
  expect(file_exists).to be_true
end

Then /^"(.*?)" should contain "(.*?)"$/ do |file, content|
  file = File.expand_path(file)
  expect(File.readlines(file).grep(/#{content}/).any?).to be_true
end

Then /^"(.*?)" should be a git repository$/ do |directory|
  file_exists = File.exist?( File.expand_path("#{directory}.git/config") )
  expect(file_exists).to be_true
end

Then /^"(.*?)" should contain packages$/ do |directory|
  pending

  files = Dir["#{directory}**/*.rb"]

  expect(files.count).to be > 0

  file.each do |file|
    file        = File.expand_path("#{directory}#{file}")
    first_line  = File.open(file, &:readline)

    expect(first_line).to eq "module HW::Packages"
  end
end

Then /^the output should be (\d+) bytes long$/ do |length|
  all_output.length.should == length.to_i
end
