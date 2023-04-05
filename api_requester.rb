module ApiRequester
    def request(url)
        request = Net::HTTP::Get.new(url)
        request["X-RapidAPI-Key"] = '1417772d2emsh3867e6be1217a7bp14edd2jsn93857756c5d6'
        request["X-RapidAPI-Host"] = 'spoonacular-recipe-food-nutrition-v1.p.rapidapi.com'
        request
      end
    
      def url(value, parameter)   
        endcode_parameter = CGI.escape(parameter)
        url = URI("#{value}#{endcode_parameter}")
        url
      end
    
      def http(url)
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        
        request = Net::HTTP::Get.new(url)
        request["X-RapidAPI-Key"] = '1417772d2emsh3867e6be1217a7bp14edd2jsn93857756c5d6'
        request["X-RapidAPI-Host"] = 'spoonacular-recipe-food-nutrition-v1.p.rapidapi.com'
        http
      end
end