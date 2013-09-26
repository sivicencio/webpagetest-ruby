require 'webpagetest/connection'

module Webpagetest
  class Client

    attr_accessor :params, :connection

    # Main params for running tests
    def initialize(params = {})
      required_params params      
      params[:f] ||= :json
      self.params = params
      self.connection = connection
    end

    def run
    end

    def locations
    end

    private

    include Connection

    def required_params(params)
      raise_error("An API key must be specified using :k variable name") if not params.has_key?(:k)
    end

    def raise_error(msg)
      raise Error.new(msg)
    end   
  end
end