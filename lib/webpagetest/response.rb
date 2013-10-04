require 'webpagetest/connection'

module Webpagetest
  # Custom response class for Webpagetest test data
  class Response

    attr_reader :test_id, :status, :result, :raw

    STATUS_BASE = 'testStatus.php'
    RESULT_BASE = 'jsonResult.php'

    def initialize(raw_response, running=true)
      @raw = raw_response
      @test_id = !running && raw_response.statusCode == 200 ? raw.data.id : raw.data.testId
    end

    # Gets the status of the request (code from Susuwatari gem)
    def get_status
      fetch_status unless status == :completed
      status
    end

    private

    # Makes the request to get the status of the test
    def fetch_status
      connection = get_connection
      response = connection.get do |req|
        req.url STATUS_BASE
        req.params['f'] = :json
        req.params['test'] = test_id
      end
      response_body = Hashie::Mash.new(JSON.parse(response.body))

      # Check 3 possible scenarios (code from Susuwatari gem)
      case response_body.data.statusCode.to_s
      when /1../
        @status = :running
      when "200"
        @status = :completed
        fetch_result
      when /4../
        @current_status = :error
      end
    end

    # Makes the request to get the test result
    def fetch_result
      connection = get_connection
      response = connection.get do |req|
        req.url RESULT_BASE
        req.params['test'] = test_id
        req.params['pagespeed'] = 1
      end
      response_body = Hashie::Mash.new(JSON.parse(response.body))
      response_body.data.status_code = response_body.statusCode
      response_body.data.status_text = response_body.statusText
      @result = response_body.data
    end

    include Connection
  end
end