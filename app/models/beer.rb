class Beer < ActiveRecord::Base
	belongs_to :brewery
	has_many :ratings
	
	def to_s
		"#{name}, #{brewery.name}"
	end	
	
	def average_rating
		ratings.average(:score)
	end
end
