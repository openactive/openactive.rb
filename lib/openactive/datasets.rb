module OpenActive
  class Datasets

    DIRECTORY="https://www.openactive.io/datasets/directory.json"

    #Returns a hash of datasets keyed on a unique id.
    def self.list
      resp = RestClient.get( DIRECTORY )
      results = JSON.parse(resp.body)
      datasets = {}
      results.each do |result|
        begin
          next unless result["publish"] && result["publish"] == true
          dataset_key = result["documentation-url"].gsub("https://github.com/", "")
          dataset_key.chomp!("/")
          datasets.merge!({ dataset_key => result })
        rescue => e
          #ignore errors
        end
      end
      datasets
    end
  end
end
