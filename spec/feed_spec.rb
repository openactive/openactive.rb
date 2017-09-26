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
    it "should yield page at end"
    it "should yield every page"
    it "should follow next page"
    it "should end at last page"
    it "should harvest all pages"
  end
end
