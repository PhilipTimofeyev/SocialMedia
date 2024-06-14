class FollowsController < ApplicationController

	def new
		@follow = Follow.new
	end

	def create
		# debugger
		requesting_user_id = params["from_user"].to_i
		requesting_user = User.find_by_id(requesting_user_id)

		follow = Follow.new
		follow.follower = requesting_user
		follow.following = current_user

		if follow.save
			redirect_to user_path(current_user.id)
			FollowChannel.broadcast_to(requesting_user, { from_user: current_user, template: 'accept' })
		end

		# debugger
	end
end
