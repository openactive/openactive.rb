require 'spec_helper'

describe OpenActive::Feed do

  context "when fetching feed" do
    before(:each) do
      WebMock.stub_request(:get, "http://www.example.com")
    end
    let(:feed) {
      OpenActive::Feed.new("http://www.example.com")
    }
    it "should fetch feed" do
      expect( feed.fetch ).to_not be_nil
    end
    it "should initialize feed" do
      expect( feed.uri ).to eql("http://www.example.com")
    end
    it "should return page" do
      expect( feed.fetch ).to be_kind_of(OpenActive::Page)
    end

  end

  it "should throw exception on error" do
    WebMock.stub_request(:get, "http://www.example.com").to_return(status: [500, "Internal Server Error"])
    feed = OpenActive::Feed.new("http://www.example.com")
    expect { feed.fetch }.to raise_error(RestClient::InternalServerError)
  end

  context "when harvesting" do
    before(:each) do
      WebMock.stub_request(:get, "http://www.example.com").to_return(body: load_fixture("multiple-items.json"))
      WebMock.stub_request(:get, "http://www.example.com/last").to_return(body: load_fixture("last-page.json"))
    end
    let(:feed) {
      OpenActive::Feed.new("http://www.example.com")
    }
    it "should return page at end" do
      page = feed.harvest
      expect( page ).to_not be_nil
    end

    it "should end at last page" do
      page = feed.harvest
      expect( page.items ).to eql([])
      expect( page.last_page? ).to eql(true)
    end

    it "should yield every page" do
      pages = 0
      feed.harvest do |page|
        pages += 1
      end
      expect( pages ).to eql(2)
    end

  end
end
