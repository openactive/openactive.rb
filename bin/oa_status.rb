#!/usr/bin/env ruby
$:.unshift File.join( File.dirname(__FILE__), "..", "lib")
require 'openactive'
require 'csv'

CSV.open("datasets.csv", "w") do |csv|

  csv << ["title", "url", "code", "valid_rpde?", "opportunity_data?", "licence"]
  OpenActive::Datasets.list.each do |site|
    feed = OpenActive::Feed.new(site[:data_url])
    begin
      page = feed.fetch
      csv << [site[:title], site[:data_url], page.response.code, page.valid_rpde?, page.declares_oa_context?, page.license]
    rescue RestClient::ExceptionWithResponse => e
      csv << [site[:title], site[:data_url], e.response.code, false]
    end
  end

end
