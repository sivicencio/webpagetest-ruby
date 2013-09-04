module Webpagetest
  class API
    def self.test_api(param)
      if param.downcase == "broccoli"
        "Gross!"
      else
        "Delicious!"
      end
    end
  end
end