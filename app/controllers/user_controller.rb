class UserController < ApplicationController
  before_action :find_user
  before_action :find_friend, only: [:follow, :unfollow]

  def follow
    @user.follow(@friend)
    render status: :no_content
  end

  def unfollow
    @user.unfollow(@friend)
    render status: :no_content
  end

  def go_to_bed
    @user.go_to_bed
    render status: :no_content
  end

  def wake_up
    @user.wake_up
    render status: :no_content
  end

  def sleeps
    render json: @user.personal_sleeps
  end

  def friends
    render json: @user.friends_record
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end

  def find_friend
    @friend = User.find(params[:friend_id])
  end
end
