class BeerClub < ActiveRecord::Base
	has_many :memberships, dependent: :destroy
	has_many :users, through: :memberships
	
	def to_s
		"#{name}, founded #{founded}"
	end
end
