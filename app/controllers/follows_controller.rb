class FollowsController < ApplicationController

	before_action :set_follows
	# after_action :update_follow_status

	def create
		# debugger
    follow = Follow.new 
    follow.follower = @follower
    follow.following = @following
    follow.accepted = false

    # debugger

    unless follow_exists?
	    if follow.save
	      FollowChannel.broadcast_to(@following, { user_id: current_user, template: 'request' })
	      update_follow_status
	    end
	  end
	end

	def update
		# debugger
	  follow = Follow.find_by(follower_id: @follower.id, following_id: @following.id)
	  follow.accepted = true

	  if follow.save
	    FollowChannel.broadcast_to(@follower, { user_id: current_user, template: 'accept' })
	    update_follow_status
	  end
	end

	def destroy
	  follow = Follow.find_by(follower_id: @follower.id, following_id: @following.id)
	  # debugger
	  follow.destroy
	  update_follow_status
	end

	private

	def follow_exists?
		Follow.exists?(follower_id: current_user.id, following_id: @following.id)
	end

	def set_follows
		follower_id = params[:follower]
		@follower = User.find_by_id(follower_id) || User.find_by_id(params[:id])

		following_id = params[:following]
		@following = User.find_by_id(following_id) || current_user
	end

	def update_follow_status
		@user = User.find_by_id(params[:following]) || User.find_by_id(params[:id])
		render turbo_stream:
			turbo_stream.replace("follows",
				partial: "users/following",
				locals: { user: @user})
	end

end
