class FollowsController < ApplicationController

	def new

	end

	def create
		# debugger
		requesting_user_id = params["from_user"].to_i
		requesting_user = User.find_by_id(requesting_user_id)

		follow = Follow.new
		follow.follower = current_user
		follow.following = requesting_user

		if follow.save
			redirect_to user_path(current_user.id)
		end

		# debugger
	end
end
