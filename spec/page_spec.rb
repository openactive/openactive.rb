require 'spec_helper'

describe OpenActive::Page do

  context "parsing response" do
    before(:each) do
        WebMock.stub_request(:get, "http://www.example.com").to_return(body: load_fixture("single-item.json"))
    end
    let(:feed) {
      OpenActive::Feed.new("http://www.example.com")
    }
    let(:page) {
      feed.fetch
    }

    it "should initialize page" do
      expect( page.uri ).to eql("http://www.example.com")
      expect( page.response ).to be_kind_of(RestClient::Response)
    end

    it "should identify next page" do
      expect( page.next_page ).to eql("http://www.example.com/next")
    end

    it "should check if feed conforms to RPDE spec" do
      expect( page.valid_rpde?).to eql(true)
    end

    it "should identify license" do
      expect( page.license ).to eql("https://creativecommons.org/licenses/by/4.0/")
    end

    it "should return items" do
      expect( page.items.length ).to eql(1)
    end

    it "should identify if page conforms to opportunity spec" do
      expect( page.declares_oa_context? ).to eql(true)
    end

    it "should correctly identify last page" do
      expect( page.last_page? ).to eql(false)

      WebMock.stub_request(:get, "http://www.example.com/last").to_return(body: load_fixture("last-page.json"))
      feed = OpenActive::Feed.new("http://www.example.com/last")
      page = feed.fetch
      expect( page.last_page? ).to eql(true)
    end

    it "should correctly identify last page" do
      expect( page.last_page? ).to eql(false)

      WebMock.stub_request(:get, "http://www.example.com/last").to_return(body: load_fixture("last-page.json"))
      feed = OpenActive::Feed.new("http://www.example.com/last")
      page = feed.fetch
      expect( page.last_page? ).to eql(true)
    end

  end



end
