require "bundler/gem_tasks"

$:.unshift File.join( File.dirname(__FILE__), "lib")

require 'rubygems'
require 'coveralls/rake/task'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)
Coveralls::RakeTask.new

task :default => [:spec]