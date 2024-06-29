class UsersController < ApplicationController
  def index
    @users = User.where.not(id: current_user.id)
  end

  def show
    @user = User.find_by_id(params[:id])
    @requests = @user.follower_relationships.where(accepted:false)
    @followers = @user.follower_relationships.where(accepted:true)
    @followings = @user.following_relationships.where(accepted:true)
  end
end
