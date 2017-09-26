module OpenActive

  class Feed
    attr_reader :uri, :current_uri

    def initialize(uri)
      @uri, @current_uri = uri, uri
    end

    def fetch
      return Page.new(@uri, RestClient.get( @uri ))
    end

    #TODO errors?
    def harvest
      page = nil
      loop do
        page = fetch
        yield page
        break if page.last_page?
        #set up next page
        current_uri = page.next_page
      end
      page
    end

  end
end