class FollowersController < ApplicationController
	before_action :authenticate_user! , only: [:create, :destroy]

	def create
		friend_id = params[:id]
		Follower.create(
			:user_id => current_user.id,
			:friend_id => friend_id,
			:following => true
		)
		redirect_to request.referrer
	end

	def destroy
		@friend_id = params[:id]
		@follower = Follower.where(:user_id => current_user.id).where(:friend_id => @friend_id)
		@follower.destroy_all
		redirect_to request.referrer
	end

	protected

	def follower_params
		params.require(:follower).permit(:user_id,:friend_id,:following)
	end

end
