require 'spec_helper'

describe OpenActive::Datasets do

  before(:each) do
    WebMock.stub_request(:get, "https://api.github.com/repos/openactive/dataset-site-generator/forks?sort=stargazers").to_return(body: load_fixture("forks.json"))
    WebMock.stub_request(:get, "https://raw.githubusercontent.com/good-gym/goodgym-oa.github.io/master/metadata.json").to_return(body: load_fixture("metadata.json"))
    WebMock.stub_request(:get, "https://raw.githubusercontent.com/acwoodcock/dataset-site-generator/master/metadata.json").to_return(body: load_fixture("metadata-not-published.json"))
  end

  it "should extract name and url" do
    datasets = OpenActive::Datasets.list
    expect( datasets.first ).to eql({ id: "goodgym-oa.github.io", title: "GoodGym Sessions", data_url: "https://www.goodgym.org/getHappenings"})
  end

  it "should extract all published datasets" do
    datasets = OpenActive::Datasets.list
    expect( datasets.length ).to eql(1)
  end

end