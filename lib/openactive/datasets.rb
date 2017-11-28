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

          dataset_key = result["documentation-url"].gsub("https://github.com/", "")
          dataset_key.chomp!("/")

          begin
            feed = OpenActive::Feed.new(result["data-url"])
            page = feed.fetch
            result.merge!({
              "uses-opportunity-model" => page.declares_oa_context?.eql?(true),
              "uses-paging-spec" => page.valid_rpde?
            })
          rescue
            #ignore errors
          end

          begin
            git_resp = RestClient.get('https://api.github.com/repos/'+ dataset_key +'/issues')
            issues = JSON.parse(git_resp.body)
            result.merge!({
              "github-issues" => issues.size
            })
          rescue
            #ignore errors
          end

          datasets.merge!({ dataset_key => result })
        rescue => e
          #ignore errors
        end
      end
      datasets
    end
  end
end