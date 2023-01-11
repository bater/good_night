class User < ApplicationRecord
  has_and_belongs_to_many :friendships,
  class_name: "User",
  join_table:  :friendships,
  foreign_key: :user_id,
  association_foreign_key: :friend_user_id
  has_many :sleeps

  def follow(friend)
    self.friendships << friend
  end

  def unfollow(friend)
    self.friendships.delete(friend)
  end

  def go_to_bed
    sleeps.create
  end

  def wake_up
    sleeps.last.update(wake_up: Time.now) if sleeps.present?
  end

  def personal_sleeps
    sleeps.order_by_created.map(&:record)
  end

  def friends_record
    friends_with_sum = sum_duration
    all_friends_sleep = batch_sleep_data
    filter_id = -> (id) { all_friends_sleep.select {|sleep| sleep.user_id == id} }
    User.find(friends_with_sum.keys).map do |friend|
      {
        name: friend.name,
        record: filter_id.call(friend.id).map(&:record),
        length: friends_with_sum[friend.id]
      }
    end
  end

  private

  def sum_duration
    all_sleep_from_friends.group(:user_id).order_by_length.sum(:duration)
  end

  def batch_sleep_data
    all_sleep_from_friends.order_by_created
  end

  def all_sleep_from_friends
    Sleep.past_week.where(user_id: friendship_ids)
  end
end
