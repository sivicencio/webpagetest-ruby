require 'webpagetest/connection'

module Webpagetest
  class Client

    attr_reader :params, :connection, :response

    TEST_BASE = 'runtest.php'
    LOCATIONS_BASE = 'getLocations.php'
    RESULT_BASE = 'jsonResult.php'

    # Main params for running tests
    def initialize(params = {})
      params = Hashie::Mash.new(params)
      required_params params
      params.f ||= :json
      params.options ||= {}
      @params = params
      @connection = get_connection params.options
    end

    # Alias method for API key
    def key
      params.k
    end

    # Runs a test bases on provided parameters
    def run_test
      # Make sure that params have been set
      raise_error('You need to pass some params to run the test. At least, an url or script') unless block_given?
      params = Hashie::Mash.new
      yield params
      raise_error('No params were passed to run_test method') if params.empty?

      response = connection.post do |req|
        req.url "#{TEST_BASE}"
        req.params['k'] = key
        req.params['f'] = @params.f
        params.each do |k, v|
          req.params[k] = v
        end
      end
      return not_available (response) unless response.status == 200
      @response = Response.new(self, Hashie::Mash.new(JSON.parse(response.body)))
    end

    # Gets the result of a test based on its id
    def test_result(test_id)
      test_params = Hashie::Mash.new( {test: test_id, pagespeed: 1} )
      response = make_request(RESULT_BASE, test_params)
      return not_available (response) unless response.status == 200
      @response = Response.new(self, Hashie::Mash.new(JSON.parse(response.body)), false)
    end

    # Gets all available test locations
    def locations
      locations_params = Hashie::Mash.new( {f: params.f} )
      response = make_request(LOCATIONS_BASE, locations_params)
      return not_available (response) unless response.status == 200
      response_body = Hashie::Mash.new(JSON.parse(response.body))
      response_body.data
    end

    private

    include Connection

    # Makes a simple request with params
    def make_request(url, params)
      response = connection.get do |req|
        req.url url
        params.each do |k, v|
          req.params[k] = v
        end
      end
      response
    end

    # Check required parameters to initialize Webpagetest
    def required_params(params)
      if params.options.nil? || params.options.url.nil? || params.options.url == Connection::ENDPOINT
        raise_error("An API key must be specified using :k variable name") if not params.key?(:k)
      end
    end

    # Returns a hashie hash with no available information
    def not_available(response)
      Hashie::Mash.new( {
        status_code: response.status,
        status_text: 'Service not available'
      } )
    end

    # Wrapper for raising errors with custom messages
    def raise_error(msg)
      raise Error.new(msg)
    end

  end
end
