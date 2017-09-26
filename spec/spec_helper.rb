require 'coveralls'
Coveralls.wear!

require 'openactive'
require 'pry'
require 'webmock/rspec'

#require 'vcr'

#VCR.configure do |config|
#  config.cassette_library_dir = "spec/vcr_cassettes"
#  config.hook_into :webmock
#end

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
end

def load_fixture(filename)
  File.read( File.join( File.dirname(__FILE__), "fixtures", filename ) )
end