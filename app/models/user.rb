class User < ActiveRecord::Base
	include RatingAverage
	
	validates :username, uniqueness: true,
								length:{minimum:3, maximum: 15}
	validates :password, length:{minimum: 4}
	validates_format_of :password, :with => /\A.*[A-Z].*\z/i
	validates_format_of :password, :with => /\A.*[0-9].*\z/i
								
	
	has_many :ratings, dependent: :destroy
	has_many :beers, through: :ratings
	has_many :memberships,  dependent: :destroy
	has_many :beer_clubs, through: :memberships
	
	has_secure_password
	
	
	def favorite_beer
		return nil if ratings.empty?
		ratings.order(score: :desc).limit(1).first.beer
	end
	
	def favorite_style
		return nil if ratings.empty?
		highest_rated_style
	end
	
	def favorite_brewery
		return nil if ratings.empty?
		highest_rated_brewery
	end	
	
	def highest_rated_style
		styles = Style.all
		avg_rating_for_style = Hash.new
		
		styles.each do |s|
			avg_rating_for_style[s] = get_average_score(ratings.reject{|r| not r.beer.style.eql?(s)})
		end
		
		avg_rating_for_style.sort_by(&:last).last.first
	end
	
	def highest_rated_brewery
		breweries = Brewery.all
		avg_rating_for_brewery = Hash.new
		
		breweries.each do |b|
			avg_rating_for_brewery[b] = get_average_score(ratings.reject{|r| not r.beer.brewery.eql?(b)})
		end
		
		avg_rating_for_brewery.sort_by(&:last).last.first
	end
	
end
