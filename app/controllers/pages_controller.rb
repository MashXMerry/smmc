class PagesController < ApplicationController
	before_action :authenticate_user! , only: [:profile]

	def index
		
	end

	def user_json
		user = User.all.order('created_at DESC')
		render :json => { 'data' => user }
	end

	def profile
		@id = current_user.id
		@profile = User.where(:id => @id)
		
		@profile.each do |profile|
			@firstname = profile.firstname
			@lastname = profile.lastname
			@fullname = profile.firstname + " " + profile.lastname
		end	
	end

end
