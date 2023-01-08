class UserController < ApplicationController
  def follow
    @user = User.find(params[:id])
    @friend = User.find(params[:friend_id])
    @user.follow(@friend)
    render status: :no_content
  end

  def unfollow
    @user = User.find(params[:id])
    @friend = User.find(params[:friend_id])
    @user.unfollow(@friend)
    render status: :no_content
  end
end
