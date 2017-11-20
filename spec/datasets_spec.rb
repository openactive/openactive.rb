require 'spec_helper'

describe OpenActive::Datasets do

  before(:each) do
    WebMock.stub_request(:get, "https://www.openactive.io/datasets/directory.json").to_return(body: load_fixture("directory.json"))
  end

  it "should extract name and url" do
    datasets = OpenActive::Datasets.list
    expect( datasets.first ).to eql({ id: "activenewham/opendata", title: "activeNewham Sessions", data_url: "https://activenewham-openactive.herokuapp.com"})
  end

  it "should extract all published datasets" do
    datasets = OpenActive::Datasets.list
    expect( datasets.length ).to eql(2)
  end

end