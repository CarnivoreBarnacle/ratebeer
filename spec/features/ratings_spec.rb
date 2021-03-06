require 'rails_helper'

include Helpers

describe "Rating" do
	let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
	let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
	let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
	let!(:user) { FactoryGirl.create :user }
	
	before :each do
		sign_in(username:"Pekka", password:"Foobar1")
	end
	
	it "when given, is registered to the beer and user who is signed in" do
		visit new_rating_path
		select('iso 3', from:'rating[beer_id]')
		fill_in('rating[score]', with:'15')
	
		expect{
			click_button "Create Rating"
		}.to change{Rating.count}.from(0).to(1)
	
		expect(user.ratings.count).to eq(1)
		expect(beer1.ratings.count).to eq(1)
		expect(beer1.average_rating).to eq(15.0)
  	end
  	
  	describe "list" do
  		let(:rating1) { FactoryGirl.create :rating, score:10, user:user, beer:beer1}
  		let(:rating2) { FactoryGirl.create :rating, score:20, user:user, beer:beer2}
  		
	  	it "has no ratings before any are added" do
			visit ratings_path
			
			expect(page).to have_content 'Number of ratings: 0'
		end
		
		it "shows ratings correctly" do
			rating1
			rating2
			visit ratings_path
			
			expect(page).to have_content 'Number of ratings: 2'
			expect(page).to have_content 'iso 3: 10 Pekka'
			expect(page).to have_content 'Karhu: 20 Pekka'
		end
	end
	
	describe "on user page" do
		let!(:rating1) { FactoryGirl.create :rating, score:10, user:user, beer:beer1}
  		let!(:rating2) { FactoryGirl.create :rating, score:20, user:user, beer:beer2}
  		
		it "are displayed correctly" do
			visit user_path(user)
			
			expect(page).to have_content 'Has rated 2 beers, Average score: 15.0'
			expect(page).to have_content 'iso 3: 10'
			expect(page).to have_content 'Karhu: 20'
		end	
		
		it "can be deleted when logged in" do
			visit user_path(user)
			
			page.find('li', :text => 'iso 3: 10').click_link('Delete')
			expect(page).to have_content 'Has rated 1 beer, Average score: 20.0'
			expect(page).to have_content 'Karhu: 20'
		end
	
	end
end