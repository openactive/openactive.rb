#!/usr/bin/env ruby
#
# Example command-line application.
#
# Dumps a sample record from a feed
# Ignores deleted records to just show those with a "modified" status
# that will contain some interesting data.
#
#
$:.unshift File.join( File.dirname(__FILE__), "..", "lib")
require 'openactive'

feed = OpenActive::Feed.new(ARGV[0] )
begin
  page = feed.fetch
  items = page.items
  items.reject! {|i| i["state"]=="deleted"}
  puts JSON.pretty_generate( items.sample )
rescue => e
  puts "Unable to load feed"
  puts e.inspect
end
