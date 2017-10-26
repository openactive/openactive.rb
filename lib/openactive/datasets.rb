module OpenActive
  class Datasets

    FORKS="https://api.github.com/repos/openactive/dataset-site-generator/forks?sort=stargazers"

    def self.list
      resp = RestClient.get( FORKS )
      forks = JSON.parse(resp.body)
      datasets = []
      forks.each do |fork|
        begin
          next unless fork["stargazers_count"] >= 1
          resp = RestClient.get("https://raw.githubusercontent.com/#{fork['full_name']}/master/metadata.json")
          metadata = JSON.parse(resp.body)
          datasets << {
              id: fork['name'],
              title: metadata["title"],
              data_url: metadata["data-url"]
          } if metadata["publish"] && metadata["publish"] == true
        rescue => e
          #ignore errors
        end
      end
      datasets
    end
  end
end