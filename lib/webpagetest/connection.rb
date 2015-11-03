module Webpagetest
  # Configures and performs connection requests
  module Connection

    ENDPOINT = 'http://www.webpagetest.org/'
    FARADAY_OPTIONS = {
      request: :url_encoded,
      response: :logger,
      adapter: Faraday.default_adapter,
    }

    def get_connection(options = {})
      options = FARADAY_OPTIONS.merge(options)
      options = Hashie::Mash.new(options)

      url = options.url || ENDPOINT

      connection = Faraday.new(url: url) do |faraday|
        faraday.request  options.request
        faraday.response options.response unless options.response.nil?
        faraday.adapter  options.adapter
      end
    end
  end
end
