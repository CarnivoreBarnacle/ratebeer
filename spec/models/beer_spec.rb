require 'rails_helper'

RSpec.describe Beer, type: :model do

	
	it "is saved" do
		beer = FactoryGirl.create :beer
		
		expect(beer).to be_valid
		expect(Beer.count).to eq(1)
	end
	
	it "is not saved without name" do
		beer = Beer.new style_id:1
		
		expect(beer).to_not be_valid
		expect(Beer.count).to eq(0)
	end
	
	it "is not saved without style" do
		beer = Beer.new name:"Test"
		
		expect(beer).to_not be_valid
		expect(Beer.count).to eq(0)
	end
	
end
