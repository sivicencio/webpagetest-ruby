require 'webpagetest/connection'

module Webpagetest
  # Custom response class for Webpagetest test data
  class Response

    attr_reader :client, :test_id, :status, :result, :raw

    STATUS_BASE = 'testStatus.php'
    RESULT_BASE = 'jsonResult.php'

    def initialize(client, raw_response, running=true)
      @client = client
      @raw = raw_response
      # ap raw_response
      if !running && raw_response.statusCode == 200
        @test_id = raw.data.id
      elsif raw.data
        @test_id = raw.data.testId
      else
        # An error occurred, for example:
        # {
        #   "statusCode" => 400,
        #   "statusText" => "Invalid Location, please try submitting your test request again."
        # }
        @test_id = nil
        # When @test_id is nil, calling `get_status` will set @status to :error.
      end
    end

    # Gets the status of the request (code from Susuwatari gem)
    def get_status
      fetch_status unless status == :completed
      status
    end

    private

    # Makes the request to get the status of the test
    def fetch_status
      connection = @client.connection
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
        @status = :error
      end
    end

    # Makes the request to get the test result
    def fetch_result
      connection = @client.connection
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
