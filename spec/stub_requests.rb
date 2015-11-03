module StubRequests
  # Stub locations request

  KEY = "your_api_key"
  TEST_URL = "http://todomvc.com/architecture-examples/emberjs/"
  TEST_ID = "131004_6T_3CX"
  OTHER_TEST_ID = "131004_GT_3A0"
  SCRIPT = "some_encoded_script"

  # Run test stub

  def run_test_request
    stub_request(:post, "http://www.webpagetest.org/runtest.php?k=#{KEY}&f=json&url=#{TEST_URL}&script=#{SCRIPT}").
      with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.2'}).
      to_return(:status => 200, :headers => {}, :body =>
        { statusCode: 200,
          statusText: "Ok",
          data: {
            testId: TEST_ID,
            ownerKey: "341035eef08ff1cd5b9cbe215414060d486c7add",
            jsonUrl: "http://www.webpagetest.org/jsonResult.php?test=131004_6T_3CX",
            xmlUrl: "http://www.webpagetest.org/xmlResult/131004_6T_3CX/",
            userUrl: "http://www.webpagetest.org/result/131004_6T_3CX/",
            summaryCSV: "http://www.webpagetest.org/result/131004_6T_3CX/page_data.csv",
            detailCSV: "http://www.webpagetest.org/result/131004_6T_3CX/requests.csv"
          }
        }.to_json
      )
  end

  def run_private_test_request
    stub_request(:post, "http://private.webpagetest.org/runtest.php?k=#{KEY}&f=json&url=#{TEST_URL}&script=#{SCRIPT}").
      with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.2'}).
      to_return(:status => 200, :headers => {}, :body =>
        { statusCode: 200,
          statusText: "Ok",
          data: {
            testId: TEST_ID,
            ownerKey: "341035eef08ff1cd5b9cbe215414060d486c7add",
            jsonUrl: "http://www.webpagetest.org/jsonResult.php?test=131004_6T_3CX",
            xmlUrl: "http://www.webpagetest.org/xmlResult/131004_6T_3CX/",
            userUrl: "http://www.webpagetest.org/result/131004_6T_3CX/",
            summaryCSV: "http://www.webpagetest.org/result/131004_6T_3CX/page_data.csv",
            detailCSV: "http://www.webpagetest.org/result/131004_6T_3CX/requests.csv"
          }
        }.to_json
      )
  end

  # Status for test run not finished stub
  def test_status_running_request
    stub_request(:get, "http://www.webpagetest.org/testStatus.php?f=json&test=#{TEST_ID}").
      with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.2'}).
      to_return(:status => 200, :headers => {}, :body => test_running_response(TEST_ID).to_json)
  end

  # Status for test run completed stub
  def test_status_completed_request
    stub_request(:get, "http://www.webpagetest.org/testStatus.php?f=json&test=#{TEST_ID}").
      with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.2'}).
      to_return(:status => 200, :headers => {}, :body => test_completed_response(TEST_ID).to_json)
  end

  # Test result after completion stub
  def test_result_request
    stub_request(:get, "http://www.webpagetest.org/jsonResult.php?pagespeed=1&test=#{TEST_ID}").
      with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.2'}).
      to_return(:status => 200, :headers => {}, :body => test_result_response(TEST_ID).to_json)
  end

  # Test result not finished stub
  def test_result_running_request
    stub_request(:get, "http://www.webpagetest.org/jsonResult.php?pagespeed=1&test=#{OTHER_TEST_ID}").
      with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.2'}).
      to_return(:status => 200, :headers => {}, :body => test_running_response(OTHER_TEST_ID).to_json)
  end

  # Status for test result not finished stub
  def status_test_result_running_request
    stub_request(:get, "http://www.webpagetest.org/testStatus.php?f=json&test=#{OTHER_TEST_ID}").
      with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.2'}).
      to_return(:status => 200, :headers => {}, :body => test_running_response(OTHER_TEST_ID).to_json)
  end

  # Status for test result completed stub
  def status_test_result_completed_request
    stub_request(:get, "http://www.webpagetest.org/testStatus.php?f=json&test=#{OTHER_TEST_ID}").
      with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.2'}).
      to_return(:status => 200, :headers => {}, :body => test_completed_response(OTHER_TEST_ID).to_json)
  end

  # Other test result after completion stub
  def other_test_result_request
    stub_request(:get, "http://www.webpagetest.org/jsonResult.php?pagespeed=1&test=#{OTHER_TEST_ID}").
      with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.2'}).
      to_return(:status => 200, :headers => {}, :body => test_result_response(OTHER_TEST_ID).to_json)
  end

  # Locations stub
  def locations_request
    stub_request(:get, "http://www.webpagetest.org/getLocations.php?f=json").
      with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.2'}).
      to_return(:status => 200, :headers => {}, :body =>
        { statusCode: 200,
          statusText: "Ok",
          data: {
            Dulles_IE6: {
              Label: "Dulles, VA USA (IE 6-10,Chrome,Firefox)",
              location: "Dulles_IE6",
              Browser: "IE 6"
            }
          }
        }.to_json
      )
  end

  # Stubs for not available API service
  def error_run_test_request
    error_response("http://www.webpagetest.org/runtest.php?k=#{KEY}&f=json&url=#{TEST_URL}&script=#{SCRIPT}")
  end

  def error_test_result_request
    error_response("http://www.webpagetest.org/jsonResult.php?pagespeed=1&test=#{OTHER_TEST_ID}")
  end

  def error_locations_request
    error_response("http://www.webpagetest.org/getLocations.php?f=json")
  end

  private

  def test_running_response(id)
    { statusCode: 101,
      statusText: "Waiting behind 142 other tests...",
      data: {
        statusCode: 101,
        statusText: "Waiting behind 142 other tests...",
        testId: id,
        runs: 1,
        fvonly: 0,
        remote: false,
        testsExpected: 2,
        location: "Dulles_IE9",
        behindCount: 142
      }
    }
  end

  def test_completed_response(id)
    { statusCode: 200,
      statusText: "Test Complete",
      data: {
        statusCode: 200,
        statusText: "Test Complete",
        testId: id,
        runs: 1,
        fvonly: 0,
        remote: false,
        testsExpected: 2,
        location: "Dulles_IE9",
        startTime: "10/04/13 4:00:04",
        elapsed: 56389,
        completeTime: "10/04/13 4:00:12",
        testsCompleted: 2
      }
    }
  end

  def test_result_response(id)
    { statusCode: 200,
      statusText: "Test Complete",
      data: {
        id: id,
        url: "http://todomvc.com/architecture-examples/emberjs/",
        summary: "http://www.webpagetest.org/results.php?test=#{id}",
        testUrl: "http://todomvc.com/architecture-examples/emberjs/",
        location: "Dulles_IE9",
        from: "Dulles, VA - IE 9 - <b>Cable</b>",
        connectivity: "Cable",
        bwDown: 5000,
        bwUp: 1000,
        latency: 28,
        plr: "0",
        completed: 1380859212,
        testerDNS: "192.168.101.1,192.168.0.1",
        runs: {
          "1" => {
            firstView: {
              URL: "http://todomvc.com/architecture-examples/emberjs/",
              loadTime: 1223,
              TTFB: 107,
              bytesOut: 8906,
              bytesOutDoc: 8906,
              bytesIn: 443497,
              bytesInDoc: 443497,
              connections: 6,
              render: 234,
              fullyLoaded: 1384,
              requests: [],
              cached: 0,
              domElements: 82,
              firstPaint: 235,
              SpeedIndexDT: 768,
              SpeedIndex: 768,
              PageSpeedScore: 77
            },
            repeatView: {
              URL: "http://todomvc.com/architecture-examples/emberjs/",
              loadTime: 321,
              TTFB: 483,
              bytesOut: 893,
              bytesOutDoc: 893,
              bytesIn: 404,
              bytesInDoc: 404,
              connections: 1,
              requests: [],
              render: 119,
              fullyLoaded: 522,
              cached: 1,
              domElements: 82,
              firstPaint: 94,
              SpeedIndexDT: 261,
              SpeedIndex: 261,
              PageSpeedScore: 58
            }
          }
        }
      }
    }
  end

  def error_response(url)
    stub_request(:any, url).
      with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.2'}).
      to_return(:status => 500, :headers => {}, :body => "")
  end

end
