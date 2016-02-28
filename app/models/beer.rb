class Beer < ActiveRecord::Base
	include RatingAverage
	
	belongs_to :brewery
	has_many :ratings, dependent: :destroy
	has_many :raters, -> {uniq}, through: :ratings, source: :user
	
	validates :name, :style_id, presence: true	
	
	belongs_to :style
	
	def self.top(n)
		Beer.all.sort_by{ |b| -(b.average_rating||0) }.first(n)
	end		
	
	def to_s
		"#{name}, #{brewery.name}"
	end	
	
end
