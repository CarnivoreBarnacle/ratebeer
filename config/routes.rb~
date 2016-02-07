Rails.application.routes.draw do
  resources :memberships
  resources :beer_clubs
	root 'breweries#index'
  	resources :users

  	resources :beers
  	resources :breweries
  
  	resources :ratings, only: [:index, :new, :create, :destroy]  
  
  	get 'signup', to: 'users#new'  
	delete 'signout', to: 'sessions#destroy'	
	  
  	resource :session, only: [:new, :create, :destroy]    
end
