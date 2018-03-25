class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # def friends?
  # 	@followers = Follower.all
  # 	@followers.each do |follower|
  # 		@followerId = follower.id
  # 	end	
  # 	userId = current_user.id
  # 	friendId = @followerId
  # end
end
