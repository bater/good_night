user = FactoryBot.create(:user, :has_friend, :with_6_hours_sleep)
first_friend = user.friendships.first
FactoryBot.create(:sleep, user_id: first_friend.id)

second_friend = FactoryBot.create(:user, :with_10_hours_sleep)
user.follow(second_friend)

third_friend = FactoryBot.create(:user, :with_6_hours_sleep)
user.follow(third_friend)

FactoryBot.create(:sleep, created_at: 2.days.ago.end_of_day, wake_up: 2.days.ago.end_of_day + 8.hours, user_id: user.id)
FactoryBot.create(:sleep, created_at: 3.days.ago.end_of_day, wake_up: 3.days.ago.end_of_day + 8.hours, user_id: user.id)
FactoryBot.create(:sleep, created_at: 4.days.ago.end_of_day, wake_up: 4.days.ago.end_of_day + 8.hours, user_id: user.id)

# user id 5 has no sleep or friend.
FactoryBot.create(:user)
