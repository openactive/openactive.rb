#!/usr/bin/env ruby
#
# Example command-line application.
# Dumps the URLs of all published datasets to the console
#
$:.unshift File.join( File.dirname(__FILE__), "..", "lib")
require 'openactive'
require 'csv'

CSV.open("datasets.csv", "w") do |csv|
  OpenActive::Datasets.list.each do |id, site|
	  puts site["dataset-site-url"]
  end
end
