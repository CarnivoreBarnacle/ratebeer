require 'rails_helper'

RSpec.describe User, type: :model do

	it "has the username set correctly" do 
		user = User.new username:"Pekka"

    	expect(user.username).to eq("Pekka")
	end
	
	it "is not saved without password" do
		user = User.create username:"Pekka"
		
		expect(user).not_to be_valid
		expect(User.count).to eq(0)
	end
	
	it "is not saved with too short password" do
		user = User.create username:"Pekka", password:"12", password_confirmation:"12"
		
		expect(user).not_to be_valid
		expect(User.count).to eq(0)
	end
	
	it "is not saved with password containing only letters" do
		user = User.create username:"Pekka", password:"test", password_confirmation:"test"
		
		expect(user).not_to be_valid
		expect(User.count).to eq(0)
	end
	
	describe "with a proper password" do	
		let(:user){ FactoryGirl.create(:user)}
		
		it "is saved" do
			expect(user).to be_valid
			expect(User.count).to eq(1)
		end
		
		it "and with two ratings, has the correct average rating" do
			user.ratings << FactoryGirl.create(:rating)
			user.ratings << FactoryGirl.create(:rating2)
			
			expect(user.ratings.count).to eq(2)
			expect(user.average_rating).to eq(15.0)
		end
	end
	
	describe "favorite beer" do
    	let(:user){FactoryGirl.create(:user) }

    	it "has method for determining one" do
      	expect(user).to respond_to(:favorite_beer)
    	end

    	it "without ratings does not have one" do
    		expect(user.favorite_beer).to eq(nil)
    	end
    
    	it "is the only rated if only one rated" do
    		beer = create_beer_with_rating(user, 10)
      
      	expect(user.favorite_beer).to eq(beer)
    	end
    
    	it "is the one with highest rating if several rated" do
      	create_beers_with_ratings(user, 10, 7)
      	best = create_beer_with_rating(user, 25)

      	expect(user.favorite_beer).to eq(best)
    	end
  	end
  	
  	describe "favorite style" do
		let(:user) {FactoryGirl.create(:user)}
		
		it "has method for determining one" do
      	expect(user).to respond_to(:favorite_style)
    	end

    	it "without ratings does not have one" do
    		expect(user.favorite_style).to eq(nil)
    	end
    
    	it "is the only rated if only one rated" do
    		beer = create_beer_with_rating(user, 10)
      
      	expect(user.favorite_style).to eq(beer.style)
    	end

  		it "is the highest rated style if several rated" do
  			create_beers_with_ratings(user, 5, 5, 5, 5)
  			beer = FactoryGirl.create(:beer)
  			FactoryGirl.create(:rating, score:10, beer:beer, user:user)
  			
  			expect(user.favorite_style).to eq(beer.style)
  		end
  	end
  	

  	describe "favorite brewery" do
		let(:user) {FactoryGirl.create(:user)}
		
		it "has method for determining one" do
      	expect(user).to respond_to(:favorite_brewery)
    	end

    	it "without ratings does not have one" do
    		expect(user.favorite_brewery).to eq(nil)
    	end
    
    	it "is the only rated if only one rated" do
    		beer = create_beer_with_rating(user, 10)
      
      	expect(user.favorite_brewery).to eq(beer.brewery)
    	end

  		it "is the highest rated style if several rated" do
  			create_beers_with_ratings(user, 5, 5, 5, 5)
			beer = create_beer_for_brewery2
  			FactoryGirl.create(:rating, score:10, beer:beer, user:user)
  			
  			
  			expect(user.favorite_brewery).to eq(beer.brewery)
  		end
	end

  	
end

###
def create_beers_with_ratings(user, *scores)
  	scores.each do |score|
		create_beer_with_rating(user, score)
	end
end  	
  	
def create_beer_with_rating(user, score)
	beer = FactoryGirl.create(:beer)
	FactoryGirl.create(:rating, score:score, beer:beer, user:user)
	beer
end

def create_beer_with_style(style)
	FactoryGirl.create(:beer, style:style)
end

def create_beer_for_brewery2
	brewery = FactoryGirl.create(:brewery2)
	FactoryGirl.create(:beer, brewery:brewery)
end



