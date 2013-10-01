module StubRequests
  # Stub locations request
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