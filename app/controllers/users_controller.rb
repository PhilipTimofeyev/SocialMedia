class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by_id(params[:id])
  end

  def follow_request
    requesting_user_id = params["id"].to_i
    requesting_user = User.find_by_id(requesting_user_id)

    follow = Follow.new
    follow.follower = requesting_user
    follow.following = current_user

    if follow.save
      FollowChannel.broadcast_to(requesting_user, { from_user: current_user, template: 'request' })
    end
  end

  def unfollow
    @follow = Follow.find_by(follower_id: current_user, following_id: params[:id])

    @follow.destroy
  end
end
