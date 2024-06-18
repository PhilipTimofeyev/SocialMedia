class UsersController < ApplicationController
  def index
    @users = User.all
    # debugger
  end

  def show
    @user = User.find_by_id(params[:id])
    @requests = @user.follower_relationships.where(accepted:false)
  end

  def follow_request
    requesting_user_id = params["id"].to_i
    requesting_user = User.find_by_id(requesting_user_id)

    follow = Follow.new 
    follow.follower = current_user
    follow.following = requesting_user
    follow.accepted = false

    if follow.save
      FollowChannel.broadcast_to(requesting_user, { from_user: current_user, template: 'request' })
    end
  end

  # def unfollow
  #   debugger
  #   @follow = Follow.find_by(follower_id: current_user, following_id: params[:id])

  #   @follow.destroy
  # end

  def accept_request
    requesting_user_id = params["id"].to_i
    requesting_user = User.find_by_id(requesting_user_id)

    follow = Follow.find_by(follower_id: requesting_user_id, following_id: current_user.id)
    follow.accepted = true
    if follow.save
      FollowChannel.broadcast_to(requesting_user, { from_user: current_user, template: 'accept' })
    end
  end

  def delete_request
    requesting_user_id = params["id"].to_i
    requesting_user = User.find_by_id(requesting_user_id)

    follow = Follow.find_by(follower_id: current_user.id, following_id: requesting_user_id)
    # debugger
    follow.destroy
    render partial: "following", locals: { user: @current_user}

  end
end
