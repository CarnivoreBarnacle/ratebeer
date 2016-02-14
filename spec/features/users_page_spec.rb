require 'rails_helper'

include Helpers

describe "User" do
  before :each do
    @user = FactoryGirl.create :user
  end

	describe "who has signed up" do
		it "can signin with right credentials" do
	      sign_in(username:"Pekka", password:"Foobar1")
	
	      expect(page).to have_content 'Welcome back!'
	      expect(page).to have_content 'Pekka'
		end
	    
		it "is redirected back to signin form if wrong credentials given" do
			sign_in(username:"Pekka", password:"wrong")
	
	      expect(current_path).to eq(signin_path)
	      expect(page).to have_content 'Wrong username or password!'
		end
	    
		it "when signed up with good credentials, is added to the system" do
			visit signup_path
			fill_in('user_username', with:'Brian')
			fill_in('user_password', with:'Secret55')
			fill_in('user_password_confirmation', with:'Secret55')
		
			expect{
				click_button('Create User')
			}.to change{User.count}.by(1)
		end
	end
  
	describe "page" do
		let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
		let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
		let!(:rating1) { FactoryGirl.create :rating, score:10, user:@user, beer:beer1}		
		
		it "displays favorite beer, style and brewery" do
			visit user_path(@user)
			
			expect(page).to have_content 'Favorite beer: iso 3, Koff'
			expect(page).to have_content 'Favorite style: Lager'
			expect(page).to have_content 'Favorite brewery: Koff'
		end
	end  
end