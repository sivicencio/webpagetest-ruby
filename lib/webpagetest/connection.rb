require 'faraday'

module Webpagetest
  # Configures and performs connection requests
  module Connection

    ENDPOINT = 'http://www.webpagetest.org/'

    private

    def connection(options = nil)
      options = {
        request: :url_encoded,
        response: :logger,
        adapter: Faraday.default_adapter,        
      } unless options.present?

      connection = Faraday.new(url: ENDPOINT) do |faraday|
        faraday.request  options.url_encoded
        faraday.response options.logger
        faraday.adapter  options.adapter
      end
    end
  end
end