class FollowsController < ApplicationController

	before_action :set_requestor

	def create
    follow = Follow.new 
    follow.follower = current_user
    follow.following = @requesting_user
    follow.accepted = false

    unless follow_exists?
	    if follow.save
	      FollowChannel.broadcast_to(@requesting_user, { user_id: current_user, template: 'request' })
	    end
	  end
	end

	def update
	  follow = Follow.find_by(follower_id: @requesting_user.id, following_id: current_user.id)
	  follow.accepted = true

	  if follow.save
	    FollowChannel.broadcast_to(@requesting_user, { user_id: current_user, template: 'accept' })
	  end
	end

	def destroy
	  follow = Follow.find_by(follower_id: current_user.id, following_id: @requesting_user.id)
	  follow.destroy
	end

	private

	def follow_exists?
		Follow.exists?(follower_id: current_user.id, following_id: @requesting_user.id)
	end

	def set_requestor
		requesting_user_id = params[:user_id].to_i
		@requesting_user = User.find_by_id(requesting_user_id)
	end

end
