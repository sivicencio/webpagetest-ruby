require 'webpagetest'
require 'webmock/rspec'
require 'stub_requests'

RSpec.configure do |config|
  config.include StubRequests
end
