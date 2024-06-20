class FollowsController < ApplicationController

	before_action :set_follower, :set_following, :set_follow

	def create
    follow = Follow.new 
    follow.follower = @follower
    follow.following = @following
    follow.accepted = false

    unless follow_exists?
	    if follow.save
	      FollowChannel.broadcast_to(@following, { user_id: current_user, template: 'request' })
	      update_follow_status
	    end
	  end
	end

	def update
	  @follow.accepted = true

	  if @follow.save
	    FollowChannel.broadcast_to(@follower, { user_id: current_user, template: 'accept' })
	    update_request_status
	  end
	end

	def destroy
	  @follow.destroy
	  update_follow_status
	end

	private

	def follow_params
		params.require(:follow).permit(:following, :follower)
	end

	def follow_exists?
		Follow.exists?(follower_id: current_user.id, following_id: @following.id)
	end

	def set_follower
		follower_id = follow_params[:follower]
		@follower = User.find_by_id(follower_id)
	end

	def set_following
		following_id = follow_params[:following]
		@following = User.find_by_id(following_id) || current_user
	end

	def set_follow
		@follow = Follow.find_by(follower_id: @follower.id, following_id: @following.id)
	end

	def update_follow_status
		@user = User.find_by_id(follow_params[:following]) || User.find_by_id(params[:id])
		render turbo_stream:
			turbo_stream.replace("follows",
				partial: "users/following",
				locals: { user: @user})
	end

	def update_request_status
		@user = User.find_by_id(follow_params[:following]) || User.find_by_id(params[:id])
		@requests = @user.follower_relationships.where(accepted:false)
		render turbo_stream:

			turbo_stream.replace("requests",
				partial: "users/requests",
				locals: { request: @requests, user: @user})
	end

end
