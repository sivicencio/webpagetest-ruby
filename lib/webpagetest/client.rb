require 'webpagetest/connection'

module Webpagetest
  class Client

    attr_reader :params, :connection, :response

    TEST_BASE = 'runtest.php'
    LOCATIONS_BASE = 'getLocations.php'

    # Main params for running tests
    def initialize(params = {})
      # Use Hashie::Mash instead of Hash object
      params = Hashie::Mash.new(params)
      required_params params      
      params.f ||= :json
      params.options ||= nil
      @params = params
      @connection = get_connection params.options
    end

    def key
      params.k
    end

    def run_test
      # Make sure that params have been set
      raise_error('You need to pass some params to run the test. At least, an url or script') unless block_given?
      params = Hashie::Mash.new
      yield params
      raise_error('No params were passed to run_test method') if params.empty?

      response = connection.get do |req|
        req.url "#{TEST_BASE}"
        req.params['k'] = key
        req.params['f'] = @params.f
        params.each do |k, v|
          req.params[k] = v
        end
      end
      return not_available (response) unless response.status == 200
      response_body = Hashie::Mash.new(JSON.parse(response.body))
      #@response = Response.new(response)
    end

    def status
    end

    def locations
      response = connection.get do |req|
        req.url "#{LOCATIONS_BASE}"
        req.params['f'] = params.f
      end
      return not_available (response) unless response.status == 200
      response_body = Hashie::Mash.new(JSON.parse(response.body))     
      locations = response_body.data
    end

    private

    include Connection

    def required_params(params)
      raise_error("An API key must be specified using :k variable name") if not params.key?(:k)
    end

    def not_available(response)
      Hashie::Mash.new( {
        status_code: response.status,
        status_text: 'Service not available'
      } )
    end

    def raise_error(msg)
      raise Error.new(msg)
    end   
  end
end