class FollowersController < ApplicationController
	before_action :authenticate_user! , only: [:create, :destroy]

	def create
		friend_id = params[:id]
		Follower.create(
			:user_id => current_user.id,
			:friend_id => friend_id,
			:following => true
		)

		Notification.create(
			:user_id => current_user.id,
			:friend_id => friend_id,
			:content => "#{current_user.firstname + " " + current_user.lastname } starts following you",
			:marked => false,
			:notif_type => "Following"
		)

		redirect_to request.referrer
	end

	def destroy
		@friend_id = params[:id]
		@follower = Follower.where(:user_id => current_user.id).where(:friend_id => @friend_id)
		@follower.update(:following => false)
		redirect_to request.referrer
	end

	def follow_again
		@friend_id = params[:id]
		@follower = Follower.where(:user_id => current_user.id).where(:friend_id => @friend_id)
		@follower.update(:following => true)
		redirect_to request.referrer
	end

	def mark_as_read
		notif_id = params[:id]
		notification = Notification.where(:id => notif_id)
		respond_to do |format|
			if notification.update(:marked => true)
				format.js
			end
		end
	end

	protected

	def follower_params
		params.require(:follower).permit(:user_id,:friend_id,:following)
	end

end
