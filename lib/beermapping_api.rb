class BeermappingApi
	
	def self.places_in(city)
		city = city.downcase
		Rails.cache.fetch(city, expires_in: 1.week ) { fetch_places_in(city)}
	end	
	
	def self.fetch_places_in(city)
		#url = "http://beermapping.com/webservice/loccity/#{key}/"
		url = "http://stark-oasis-9187.herokuapp.com/api/#{ERB::Util.url_encode(city)}"

    	response = HTTParty.get url
    	places = response.parsed_response["bmp_locations"]["location"]

    	return [] if places.is_a?(Hash) and places['id'].nil?

    	places = [places] if places.is_a?(Hash)
    	places.map do | place |
      	Place.new(place)
    	end
	end

end