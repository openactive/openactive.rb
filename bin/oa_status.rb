#!/usr/bin/env ruby
#
# Example command-line application.
#
# Creates a CSV file with the current status of each published RPDE feed
# name, url, response when requesting first page and if successful whether it
# is valid and uses the standard opportunity model
#
# Essentially equivalent of the most basic parts of status.openactive.io
#
#
$:.unshift File.join( File.dirname(__FILE__), "..", "lib")
require 'openactive'
require 'csv'

CSV.open("datasets.csv", "w") do |csv|

  csv << ["title", "url", "code", "valid_rpde?", "opportunity_data?"]
  OpenActive::Datasets.list.each do |id, site|
    feed = OpenActive::Feed.new(site["data-url"])
    begin
      page = feed.fetch
      csv << [site["title"], site["data-url"], page.response.code, page.valid_rpde?, page.declares_oa_context?]
    rescue RestClient::ExceptionWithResponse => e
      csv << [site["title"], site["data-url"], e.response.code, false]
    end
  end

end
