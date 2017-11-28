module OpenActive
  class Datasets

    DIRECTORY="https://www.openactive.io/datasets/directory.json"

    def self.list
      resp = RestClient.get( DIRECTORY )
      results = JSON.parse(resp.body)
      datasets = {}
      results.each do |result|
        begin
          next unless result["publish"] && result["publish"] == true

          feed = OpenActive::Feed.new(result["data-url"])
          page = feed.fetch

          result.merge!({
            "uses-opportunity-model" => page.declares_oa_context?,
            "uses-paging-spec" => page.valid_rpde?
          })

          datasets.merge!({
            result["documentation-url"].gsub("https://github.com/", "") => result
          })
        rescue => e
          #ignore errors
        end
      end
      datasets
    end
  end
end