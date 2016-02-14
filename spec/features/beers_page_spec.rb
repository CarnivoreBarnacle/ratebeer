require 'rails_helper'

describe "Beer" do
	let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
	
	it "can be added" do
		add_beer(name:"Test")
		
		expect(Beer.count).to eq(1)
		expect(page).to have_content 'Beer was successfully created.'
		expect(page).to have_content 'Test'
	end
	
	it "cannot be added without a name" do
		visit new_beer_path
		click_button 'Create Beer'
		
		expect(Beer.count).to eq(0)
		expect(page).to have_content 'Name can\'t be blank'
	end
end