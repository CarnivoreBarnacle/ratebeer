require 'rails_helper'

describe "Places" do

	before :each do
		allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      	[ Place.new( name:"Oljenkorsi", id: 1 ) ]
    	)
    	
    	allow(BeermappingApi).to receive(:places_in).with("test").and_return(
      	[ Place.new( name:"Oljenkorsi", id: 1 ), Place.new( name:"Test2", id: 2), Place.new( name:"Test3", id: 3) ]
    	)
    	
    	allow(BeermappingApi).to receive(:places_in).with("empty").and_return(
      	[ ]
    	)
	end

  	it "if one is returned by the API, it is shown at the page" do
    	visit places_path
    	fill_in('city', with: 'kumpula')
    	click_button "Search"

    	expect(page).to have_content "Oljenkorsi"
	end
	
	it "if multiple are returned by the API, all are shown at the page" do
    	visit places_path
    	fill_in('city', with: 'test')
    	click_button "Search"

    	expect(page).to have_content "Oljenkorsi"
    	expect(page).to have_content "Test2"
    	expect(page).to have_content "Test3"
	end
	
	it "if none are returned by the API, message is shown" do
		visit places_path
    	fill_in('city', with: 'empty')
    	click_button "Search"
    	
    	expect(page).to have_content "No locations in empty"
	end
end