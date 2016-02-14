module RatingAverage
	extend ActiveSupport::Concern

	def average_rating
		ratings.average(:score)
	end
	
	def get_average_score(array)
		return 0 if array.empty?	
	
		result = 0		
		array.each do |r|
			result = result + r.score
		end
		
		result/array.length
	end
end