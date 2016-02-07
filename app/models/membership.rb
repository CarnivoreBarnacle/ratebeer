class Membership < ActiveRecord::Base
	belongs_to :user
	belongs_to :beer_club
	
	validate :is_unique_membership	
	
	def is_unique_membership
		Membership.all.each do |membership|
			if user_id == membership.user_id and beer_club_id == membership.beer_club_id
				errors.add(:user_id,"is already member of #{membership.beer_club.name}")
				break
			end
		end
	end
end
