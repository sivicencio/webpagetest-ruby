require 'hashie'
require 'json'
require 'faraday'
require "webpagetest/version"
require 'webpagetest/error'
require 'webpagetest/client'

module Webpagetest
  def self.new(params)
    Webpagetest::Client.new(params)
  end
end
