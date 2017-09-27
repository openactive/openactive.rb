require "rest-client"
require "json"
require "uri"

require "openactive/datasets.rb"
require "openactive/feed.rb"
require "openactive/page.rb"

module OpenActive
  CONTEXT = "https://www.openactive.io/ns/oa.jsonld"
end