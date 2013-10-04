module StubRequests
  # Stub locations request

  KEY = "d88f58f6bb8c44ab9622a346bc93342d"
  URL = "http://todomvc.com/architecture-examples/emberjs/"
  SCRIPT = "some_encoded_script"

  def run_test_request
    stub_request(:post, "http://www.webpagetest.org/runtest.php?k=#{KEY}&f=json&url=#{URL}&script=#{SCRIPT}").
      with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.8.8'}).
      to_return(:status => 200, :headers => {}, :body =>
        { "statusCode" => 200,
          "statusText" => "Ok",
          "data" => {
            "testId" => "131004_6T_3CX",
            "ownerKey" => "341035eef08ff1cd5b9cbe215414060d486c7add",
            "jsonUrl" => "http://www.webpagetest.org/jsonResult.php?test=131004_6T_3CX",
            "xmlUrl" => "http://www.webpagetest.org/xmlResult/131004_6T_3CX/",
            "userUrl" => "http://www.webpagetest.org/result/131004_6T_3CX/",
            "summaryCSV" => "http://www.webpagetest.org/result/131004_6T_3CX/page_data.csv",
            "detailCSV" => "http://www.webpagetest.org/result/131004_6T_3CX/requests.csv"
          }
        }.to_json
      )
  end


  def locations_request
    stub_request(:get, "http://www.webpagetest.org/getLocations.php?f=json").
      with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.8.8'}).
      to_return(:status => 200, :headers => {}, :body =>
        { "statusCode" => 200,
          "statusText" => "Ok",
          "data" => {
            "Dulles_IE6" => {
              "Label" => "Dulles, VA USA (IE 6-10,Chrome,Firefox)",
              "location" => "Dulles_IE6",
              "Browser" => "IE 6"
            }
          } 
        }.to_json)
  end
end