#!/usr/bin/env ruby
$:.unshift File.join( File.dirname(__FILE__), "..", "lib")

require 'openactive'

feed = OpenActive::Feed.new(ARGV[0])

pages = 0

feed.harvest do |page|
  $stderr.puts page.uri
  File.open( File.join(ARGV[1], "#{pages}.json"), "w" ) do |f|
    f.puts JSON.dump(page.body)
    pages += 1
  end
end