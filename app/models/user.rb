class User < ApplicationRecord
  has_and_belongs_to_many :friendships,
  class_name: "User",
  join_table:  :friendships,
  foreign_key: :user_id,
  association_foreign_key: :friend_user_id
  has_many :sleep

  def follow(friend)
    self.friendships << friend
  end

  def unfollow(friend)
    self.friendships.delete(friend)
  end

  def go_to_bed
    sleep.create
  end

  def wake_up
    sleep.last.update(wake_up: Time.now)
  end

  def sleeps
    sleep.map(&:record)
  end

  def sleeps_past_week
    sleep.past_week.map(&:record)
  end

  def friends_record
    friendships.map do |friend|
      {
        name: friend.name,
        record: friend.sleeps_past_week,
        length: friend.sleep.past_week.sum(:duration)
      }
    end.sort_by{|f| f[:length]}.reverse
  end
end
