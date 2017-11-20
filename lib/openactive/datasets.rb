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