class PagesController < ApplicationController

	def user_json
		user = User.all.order('created_at DESC')
		render :json => { 'data' => user }
	end

end
