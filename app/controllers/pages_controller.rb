class PagesController < ApplicationController
	before_action :authenticate_user! , only: [:profile]

	def index
		
	end

	def user_json
		user = User.all.order('created_at DESC')
		render :json => { 'data' => user }
	end

	def profile
		@user = User.new
		@id = current_user.id
		@profile = User.where(:id => @id)
		@bio = User.select(:bio).where(:id => @id)
		
		@profile.each do |profile|
			@firstname = profile.firstname
			@lastname = profile.lastname
			@bio = profile.bio
			if @current_user.middlename.blank?
				@fullname = profile.firstname + " " + profile.lastname
			else
				@fullname = profile.firstname + " " + profile.middlename + " " + profile.lastname	
			end
		end	
	end

	def updateBio
		@user = User.find(params[:id])
		# @user.update(:bio => "Sample Bio")
		bio = params[:bio]
		@user.update_attribute(:bio , bio)
		@user.save
		redirect_to profile_path
	end

end
