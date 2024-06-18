class FollowsController < ApplicationController

	def create
		# debugger
    requesting_user_id = params[:user_id].to_i
    requesting_user = User.find_by_id(requesting_user_id)

    follow = Follow.new 
    follow.follower = current_user
    follow.following = requesting_user
    follow.accepted = false

    if follow.save
      FollowChannel.broadcast_to(requesting_user, { user_id: current_user, template: 'request' })
    end

	end

	def update
		debugger
	  requesting_user_id = params[:user_id].to_i
	  requesting_user = User.find_by_id(requesting_user_id)

	  follow = Follow.find_by(follower_id: requesting_user_id, following_id: current_user.id)
	  follow.accepted = true

	  if follow.save
	    FollowChannel.broadcast_to(requesting_user, { user_id: current_user, template: 'accept' })
	  end
	end

	def destroy
		# debugger
	  requesting_user_id = params[:user_id].to_i
	  requesting_user = User.find_by_id(requesting_user_id)

	  follow = Follow.find_by(follower_id: current_user.id, following_id: requesting_user_id)
	  follow.destroy
	  # render partial: "following", locals: { user: @current_user}

	end

end
