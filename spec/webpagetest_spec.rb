require 'webpagetest'

describe Webpagetest::API do
  it "broccoli is gross" do
    Webpagetest::API.test_api("Broccoli").should eql("Gross!")
  end

  it "anything else is delicious" do
    Webpagetest::API.test_api("Not Broccoli").should eql("Delicious!")
  end
end