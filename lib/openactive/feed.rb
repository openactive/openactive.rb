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
        @current_uri = to_abs(page.next_page)
        sleep(sleep)
      end
      page
    end

    private

      def to_abs(next_page)
        if !next_page.start_with?("/")
          return next_page
        end
        return (URI.parse(uri) + next_page).to_s
      end
  end
end