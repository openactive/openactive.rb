module OpenActive
  class Page
    attr_reader :uri, :response

    def initialize(uri, response)
      @uri, @response = uri, response
    end

    def last_page?
      return (@uri == next_page && items.empty?)
    end

    def next_page
      return body["next"]
    end

    def license
      return body["license"]

    end
    def items
      return body["items"]
    end

    def declares_oa_context?
      return nil if items.empty?
      to_check = nil
      items.each do |item|
        if item["data"]
          to_check = item
          break
        end
      end
      return nil if to_check.nil?
      return to_check["data"]["@context"].include?(OpenActive::CONTEXT)
    end

    def body
      if @body.nil?
        begin
          @body = JSON.parse(response.body)
        rescue
          @body = nil
        end
      end
      @body
    end
  end
end