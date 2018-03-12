Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
	root 'pages#index'
	
	#JSON routes
	get 'users/users_json' , to: 'pages#user_json' 

end
