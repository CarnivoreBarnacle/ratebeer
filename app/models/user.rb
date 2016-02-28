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
		favorite :style
	end
	
	def favorite_brewery
		favorite :brewery
	end	
	
	def favorite(category)
		return nil if ratings.empty?

		rated = ratings.map{ |r| r.beer.send(category) }.uniq
		rated.sort_by { |item| -rating_of(category, item) }.first
	end	

	def self.top(n)
		User.all.sort_by{ |u| -(u.ratings.count) }.first(n)
	end	
	
	def rating_of(category, item)
    ratings_of = ratings.select{ |r| r.beer.send(category)==item }
    ratings_of.map(&:score).inject(&:+) / ratings_of.count.to_f
  end
end
