Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
	root 'pages#index'
	
	#JSON routes
	get 'users/users_json' , to: 'pages#user_json' 
	get 'user/user_bio/:id' , to: 'pages#bio_json'


	#CUSTOM ROUTES
	get '/profile' , to: 'pages#profile' , as: 'profile'
	get '/user/search-user', to: 'pages#searchUser' , as: 'search_user'
	put '/user/update-bio/:id' , to: 'pages#updateBio' , as: 'update_bio'

	# Follower
	post '/user/follow-friend/:id' , to: 'followers#create' , as: 'follow'
	delete '/user/unfollow-friend/:id', to: 'followers#destroy' , as: 'unfollow'
	put '/user/follow-again/:id' , to: 'followers#follow_again' , as: 'follow_again'

end
