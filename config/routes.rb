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
	get "/users/profile/:username" , to: 'pages#user_account' , as: 'user_account'
	get "/users/profile/:id" , to: 'pages#user_account' , as: 'user_account_id'
	get '/profile' , to: 'pages#profile' , as: 'profile'
	get '/followers' , to: 'pages#followers' , as: 'followers'
	get '/user/search-user', to: 'pages#searchUser' , as: 'search_user'
	put '/user/update-bio/:id' , to: 'pages#updateBio' , as: 'update_bio'

	# Follower
	get '/user/unfollow-friend/:id' , to: 'pages#redirect'
	post '/user/follow-friend/:id' , to: 'followers#create' , as: 'follow'
	delete '/user/unfollow-friend/:id', to: 'followers#destroy' , as: 'unfollow'
	put '/user/mark-as-read/:id' , to: 'followers#mark_as_read' , as: 'mark'
	put '/user/follow-again/:id' , to: 'followers#follow_again' , as: 'follow_again'

	# FRIENDS

end
