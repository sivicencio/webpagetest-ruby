require 'spec_helper'

describe Webpagetest do
  let(:key){ "d88f58f6bb8c44ab9622a346bc93342d" }
  let(:test_url){ "http://todomvc.com/architecture-examples/emberjs/" }
  let(:wpt) { Webpagetest.new(k: key) }

  it 'should establish a connection with required params' do
    wpt.connection.should_not be_nil
    wpt.connection.should be_instance_of Faraday::Connection
  end

  it 'should run a test with parameters included' do
     run_test_request
     response = wpt.run_test do |params|
      params.url = test_url
      params.script = 'some_encoded_script'
     end
     response.test_id.should be_a(String)
     response.raw.should be_instance_of Hashie::Mash
     response.raw.statusCode.should be(200)
  end

  it 'should get available locations' do
    locations_request
    locations = wpt.locations
    locations.should be_instance_of Hashie::Mash 
    locations.values.first.Label.should_not be_nil
  end
end