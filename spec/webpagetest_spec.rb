require 'spec_helper'

describe Webpagetest do
  # Local variables
  let(:key){ "your_api_key" }
  let(:test_url){ "http://todomvc.com/architecture-examples/emberjs/" }
  let(:script){ "some_encoded_script" }
  let(:test_id) { "131004_GT_3A0" }
  let(:wpt) { Webpagetest.new(k: key) }

  # Test case when establishing a connection (no requests yet)
  it 'should establish a connection with required params' do
    wpt.connection.should_not be_nil
    wpt.connection.should be_instance_of Faraday::Connection
  end

  # Set of test cases when running a test
  it 'should run a test with parameters included' do
    run_test_request
    response = wpt.run_test do |params|
      params.url = test_url
      params.script = script
    end
    response.test_id.should be_a(String)
    response.raw.should be_instance_of Hashie::Mash
    response.raw.statusCode.should be(200)
    response.test_id.should_not be(nil)
  end

  it 'should get the status of a test after being run' do
    run_test_request
    response = wpt.run_test do |params|
      params.url = test_url
      params.script = script
    end

    # Get status while test is running
    test_status_running_request
    status = response.get_status
    status.should be(:running)
    response.result.should be(nil)

    # Get status when test is completed
    test_status_completed_request
    test_result_request
    status = response.get_status
    status.should be(:completed)
  end

  it 'should get the result of a test after its completion' do
    run_test_request
    response = wpt.run_test do |params|
      params.url = test_url
      params.script = script
    end
    test_status_completed_request
    test_result_request
    response.get_status
    response.result.should_not be(nil)
    response.result.should be_instance_of Hashie::Mash
    response.result.runs[1].firstView.loadTime.should be_a(Fixnum)
  end

  # Set of test cases for retrieving a test result
  it 'should get the result of a running test using its id' do
    test_result_running_request
    response = wpt.test_result(test_id)
    response.test_id.should be_a(String)

    status_test_result_running_request
    status = response.get_status
    status.should be(:running)
    response.result.should be(nil)

    status_test_result_completed_request
    other_test_result_request
    status = response.get_status
    status.should be(:completed)
  end

  it 'should get the result of a completed test using its id' do
    other_test_result_request
    response = wpt.test_result(test_id)
    response.test_id.should be_a(String)

    status_test_result_completed_request
    response.get_status
    response.result.should_not be(nil)
    response.result.should be_instance_of Hashie::Mash
    response.result.runs[1].firstView.loadTime.should be_a(Fixnum)
  end

  # Test case for retrieving available locations
   it 'should get available locations' do
    locations_request
    locations = wpt.locations
    locations.should be_instance_of Hashie::Mash
    locations.values.first.Label.should_not be_nil
  end

  # Set of test cases when Webpagetest API is not available
  it 'should get a service not available response after trying to run a test' do
    error_run_test_request
    response = wpt.run_test do |params|
      params.url = test_url
      params.script = script
    end
    response.key?(:status_code).should be(true)
    response.status_code.should be_a(Fixnum)
    response.status_code.should_not be(200)
  end

  it 'should get a service not available response after trying to get a test result' do
    error_test_result_request
    response = wpt.test_result(test_id)
    response.key?(:status_code).should be(true)
    response.status_code.should be_a(Fixnum)
    response.status_code.should_not be(200)
  end

  it 'should get a service not available response after trying to get locations' do
    error_locations_request
    locations = wpt.locations
    locations.key?(:status_code).should be(true)
    locations.status_code.should be_a(Fixnum)
    locations.status_code.should_not be(200)
  end

  describe 'API key' do

    it 'should not raise if no API key is provided on custom instance' do
      connection_options = {
        request: :url_encoded,
        response: :logger,
        adapter: Faraday.default_adapter,
        url: 'http://customwebpagetest.com/',
      }
      expect {
        Webpagetest.new(options: connection_options)
      }.to_not raise_error
    end

    it 'should raise if no API key is provided on webpagetest.org' do
      connection_options = {
        request: :url_encoded,
        response: :logger,
        adapter: Faraday.default_adapter,
        url: Webpagetest::Connection::ENDPOINT,
      }
      expect {
        Webpagetest.new(options: connection_options)
      }.to raise_error(Webpagetest::Error)
    end
  end
end