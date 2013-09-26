require 'webpagetest/connection'

module Webpagetest
  class Client

    attr_accessor :params

    # Main params for running tests
    def initialize(params = {})
      params.fetch(:k)
      params[:f] ||= :json
      self.params = params
    end

    private

    include Connection
  end
end