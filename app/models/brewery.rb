class Brewery < ActiveRecord::Base
	include RatingAverage

	has_many :beers, dependent: :destroy
	has_many :ratings, through: :beers
	
	validates :name, presence: true	
	validates :year, numericality: {greater_than_or_equal_to: 1024, only_integer: true}
	validate :year_cannot_be_greater_than_current_year
	
	scope :active, -> { where active:true }
	scope :retired, -> { where active:[nil,false] }	
	
	def print_report
		puts name
		puts "Established at #{year}"
		puts "Number of beers #{beers.count}"
	end
	
	def self.top(n)
		Brewery.all.sort_by{ |b| -(b.average_rating||0) }.first(n)
	end	
	
	def restart
		self.year = 2016
	end
	
	def year_cannot_be_greater_than_current_year
		if year > Time.now.year
			errors.add(:year, "can't be greater than current year (#{Time.now.year})")
		end
	end
	
	def beer_count
		self.beers.count
	end
end
