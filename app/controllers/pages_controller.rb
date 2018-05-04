class PagesController < ApplicationController
	before_action :notification , only: [:index, :profile, :searchUser, :user_account]
	before_action :authenticate_user! , 
	only: [:profile , :user_json , :searchUser , :redirect, :notifications, :user_account, :followers]
	
	def index

	end

	def user_json
		user = User.select(:firstname,:lastname,:id ,:email, :username).order('created_at DESC')
		render :json => user
	end

	def profile
		@following = Follower.where(:user_id => current_user.id , :following => true)
		@follower = Follower.where(:friend_id => current_user.id , :following => true)
		# ==========================================================================
		@user = User.new
		@id = current_user.id
		@profile = User.where(:id => @id)
		@bio = current_user.bio
		# ==========================================================================
		@profile.each do |profile|
			@firstname = profile.firstname
			@lastname = profile.lastname
			@bio = profile.bio
			@email = profile.email
			if @current_user.middlename.blank?
				@fullname = profile.firstname + " " + profile.lastname
			else
				@fullname = profile.firstname + " " + profile.middlename + " " + profile.lastname	
			end

			if current_user.username.blank?
				@username = ""
			else
				@username = "("+ current_user.username + ")"	
			end #if 
		end	# @profile.each
	end

	def updateBio
		@user = User.find(params[:id])
		@user.update(bio_params)
		respond_to do |format|
			if @user.save
				format.html { redirect_to profile_path }
				format.js
			end
		end	
	end

	def bio_json
    userid = User.find(params[:id])
    bio = User.select(:bio).where(:id => userid)
    render :json => { "data" => bio }
  end

  def searchUser
		@user = User.where(["username LIKE?" , "%#{params[:search]}%"]).limit(10).order('firstname ASC')
  	if params[:search].blank?
			redirect_to root_path
  	else
  		@user.each do |user|
  			@following = Follower.where(:user_id => current_user.id , :friend_id => user.id, :following => true)
  			@unfollowed = Follower.where(:user_id => current_user.id , :friend_id => user.id, :following => false)
  		end
  	end
  end

  def user_account
  	if params[:username] === current_user.username
  		redirect_to profile_path
  	else
	  	@user = User.where(:username => params[:username])
				if @user.blank?
					render 'redirect'
				else		
					@user = User.all.where(:username => params[:username])
					@user.each do |user|
						@following_count = Follower.where(:user_id => user.id , :following => true)
						@follower_count = Follower.where(:friend_id => user.id , :following => true)
						# ==============================================================================
						@following = Follower.where(:user_id => current_user.id , :friend_id => user.id, :following => true)
  					@unfollowed = Follower.where(:user_id => current_user.id , :friend_id => user.id, :following => false)
					end	
				end
  	end
  end

  def redirect
  	respond_to do |format|
  		format.html { redirect_to profile_path , notice: "You are doing something FISHY !!" }
  	end	
  end

  protected

  def notification
  	if user_signed_in?
	  	@unread_notification = Notification.all.where(:friend_id => current_user.id , :marked => false)
			@notification  = Notification.all.where(:friend_id => current_user.id).order('created_at DESC')
  	end
  end

  def user_params
  	params.require(:user).permit(:firstname, :middlename, :lastname, :bio, :email)
  end
	
	def bio_params
	  params.require(:user).permit(:bio)
	end  

end
