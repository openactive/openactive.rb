module OpenActive

  class Feed
    attr_reader :uri, :current_uri

    def initialize(uri)
      @uri, @current_uri = uri, uri
    end

    def fetch
      return Page.new(@current_uri, RestClient.get( @current_uri ))
    end

    def harvest(sleep=0)
      page = nil
      current_uri = uri
      loop do
        page = fetch
        yield page if block_given?
        break if page.last_page?
        #set up next page
        @current_uri = page.next_page
        sleep(sleep)
      end
      page
    end

  end
end