class PagesController < ApplicationController
	before_action :authenticate_user! , only: [:profile , :user_json , :searchUser]
	
	def index
		if user_signed_in?
			@notification  = Notification.all.where(:friend_id => current_user.id , :marked => false)
		end
	end

	def user_json
		user = User.select(:firstname,:lastname,:id ,:email).order('created_at DESC')
		render :json => user
	end

	def profile
		@following = Follower.where(:user_id => current_user.id , :following => true)
		@follower = Follower.where(:friend_id => current_user.id , :following => true)
		@notification  = Notification.all.where(:friend_id => current_user.id, :marked => false)
		@user = User.new
		@id = current_user.id
		@profile = User.where(:id => @id)
		
		@profile.each do |profile|
			@firstname = profile.firstname
			@lastname = profile.lastname
			@bio = profile.bio
			if @current_user.middlename.blank?
				@fullname = profile.firstname + " " + profile.lastname
			else
				@fullname = profile.firstname + " " + profile.middlename + " " + profile.lastname	
			end

			if current_user.username.blank?
				@username = ""
			else
				@username = "("+ current_user.username + ")"	
			end
		end	
	end

	def updateBio
		@user = User.find(params[:id])
		@user.update(bio_params)
		respond_to do |format|
			if @user.save
				format.html { redirect_to profile_path }
				# format.js
			end
		end	
	end

	def bio_json
    userid = User.find(params[:id])
    bio = User.select(:bio).where(:id => userid)
    render :json => { "data" => bio }
  end

  def searchUser
  	@notification  = Notification.all.where(:friend_id => current_user.id , :marked => false)
  	if params[:search].blank?
  		redirect_to root_path
  	else
  		@user = User.all.where(["username LIKE ?" , "#{params[:search]}"]).limit(10)

  		@user.each do |user|
  			@following = Follower.where(:user_id => current_user.id , :friend_id => user.id, :following => true)
  			@unfollowed = Follower.where(:user_id => current_user.id , :friend_id => user.id, :following => false)
  		end
  	end
  end

  protected

  def notification
  	@notification  = Notification.all.where(:friend_id => current_user.id)
  end

  def user_params
  	params.require(:user).permit(:firstname, :middlename, :lastname, :bio, :email)
  end
	
	def bio_params
	  params.require(:user).permit(:bio)
	end  

end
