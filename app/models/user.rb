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
end
