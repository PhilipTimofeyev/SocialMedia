class FollowsController < ApplicationController

	before_action :set_requestor
	# after_action :update_follow_status

	def create
    follow = Follow.new 
    follow.follower = current_user
    follow.following = @requesting_user
    follow.accepted = false

    unless follow_exists?
	    if follow.save
	      FollowChannel.broadcast_to(@requesting_user, { user_id: current_user, template: 'request' })
	      update_follow_status
	    end
	  end
	end

	def update
	  follow = Follow.find_by(follower_id: @requesting_user.id, following_id: current_user.id)
	  follow.accepted = true

	  if follow.save
	    FollowChannel.broadcast_to(@requesting_user, { user_id: current_user, template: 'accept' })
	    update_follow_status
	  end
	end

	def destroy
	  follow = Follow.find_by(follower_id: current_user.id, following_id: @requesting_user.id)
	  follow.destroy
	  update_follow_status
	end

	private

	def follow_exists?
		Follow.exists?(follower_id: current_user.id, following_id: @requesting_user.id)
	end

	def set_requestor
		requesting_user_id = params[:id].to_i
		@requesting_user = User.find_by_id(requesting_user_id)
	end

	def update_follow_status
		@user = @user = User.find_by_id(params[:id])
		render turbo_stream:
			turbo_stream.replace("follows",
				partial: "users/following",
				locals: { user: @user})
	end

end
