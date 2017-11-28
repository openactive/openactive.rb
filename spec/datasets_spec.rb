require 'spec_helper'

describe OpenActive::Datasets do

  before(:each) do
    WebMock.stub_request(:get, "https://www.openactive.io/datasets/directory.json").to_return(body: load_fixture("directory.json"))
    WebMock.stub_request(:get, "https://activenewham-openactive.herokuapp.com/").to_return(status: 200, body: load_fixture("single-item.json"))
    WebMock.stub_request(:get, "https://makesweat.com/service/openactive.php").to_return(status: 200, body: load_fixture("single-item.json"))
    WebMock.stub_request(:get, "https://api.github.com/repos/activenewham/opendata/issues").to_return(status: 200, body: "[{}]", headers: {})
    WebMock.stub_request(:get, "https://api.github.com/repos/makesweat/opendata/issues").to_return(status: 200, body: "[{}]", headers: {})
  end

  it "should extract name and url" do
    datasets = OpenActive::Datasets.list
    expect( datasets["activenewham/opendata"] ).to eql({
      "dataset-site-url" => "http://data.activenewham.org.uk/",
      "title" => "activeNewham Sessions",
      "description" => "Session data from the activenewham.org.uk site",
      "publisher-name" => "activeNewham",
      "publisher-url" => "https://www.activenewham.org.uk",
      "keyword-1" => "Newham",
      "keyword-2" => "Leisure",
      "data-url" => "https://activenewham-openactive.herokuapp.com",
      "created" => "2017-02-17",
      "documentation-url" => "https://github.com/activenewham/opendata",
      "rpde-version" => "0.2.3",
      "license-name" => "Creative Commons Attribution Licence (CC-BY v4.0)",
      "license-url" => "https://creativecommons.org/licenses/by/4.0/",
      "attribution-text" => "activeNewham",
      "attribution-url" => "http://data.activenewham.org.uk/",
      "mailchimp" => "require([\"mojo/signup-forms/Loader\"], function(L) { L.start({\"baseUrl\":\"mc.us15.list-manage.com\",\"uuid\":\"139e08e5077eeef9048052685\",\"lid\":\"5eb5e5184a\"}) })",
      "copyright-notice" => "",
      "github-issues" => 1,
      "odi-certificate-number" => "",
      "publish" => true,
      "uses-opportunity-model" => true,
      "uses-paging-spec" => true,
      "example-url" => [
       "https://imin-ltd.github.io/gladstone-adapter-documentation/example.json"
      ]
    })
  end

  it "should extract all published datasets" do
    datasets = OpenActive::Datasets.list
    expect( datasets.length ).to eql(2)
  end

end