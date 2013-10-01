require 'spec_helper'

describe Webpagetest do
  let(:key){ "d88f58f6bb8c44ab9622a346bc93342d" }

  it 'should establish a connection with required params' do
    wpt = Webpagetest.new(k: :key)
    wpt.connection.should_not be_nil
    wpt.connection.should be_instance_of Faraday::Connection
  end

  it 'should get available locations' do
    wpt = Webpagetest.new(k: :key)
    locations_request
    locations = wpt.locations
    locations.should be_instance_of Hashie::Mash 
    locations.values.first.Label.should_not be_nil
  end
end