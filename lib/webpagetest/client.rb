require 'webpagetest/connection'

module Webpagetest
  class Client

    attr_accessor :params, :connection

    # Main params for running tests
    def initialize(params = {})
      # Use Hashie::Mash instead of Hash object
      params = Hashie::Mash.new(params)
      required_params params      
      params.f ||= :json
      params.options ||= nil
      self.params = params
      self.connection = get_connection params.options
    end

    def key
      self.params.k
    end

    def run
    end

    def locations
    end

    private

    include Connection

    def required_params(params)
      raise_error("An API key must be specified using :k variable name") if not params.key?(:k)
    end

    def raise_error(msg)
      raise Error.new(msg)
    end   
  end
end