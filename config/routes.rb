Rails.application.routes.draw do
  resources :styles
  	resources :memberships
  	resources :beer_clubs
	root 'breweries#index'
  	resources :users

  	resources :beers
  	resources :breweries
  
  	resources :ratings, only: [:index, :new, :create, :destroy]  
  
  	get 'signin', to: 'sessions#new'
  	get 'signup', to: 'users#new'  
	delete 'signout', to: 'sessions#destroy'	
	
	resources :places, only:[:index, :show]
	post 'places', to:'places#search'
	  
  	resource :session, only: [:new, :create, :destroy]    
end
