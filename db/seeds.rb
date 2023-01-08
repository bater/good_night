user = FactoryBot.create(:user, :has_friend, :with_6_hours_sleep)
first_friend = user.friendships.first
FactoryBot.create(:sleep, user_id: first_friend.id)

second_friend = FactoryBot.create(:user, :with_6_hours_sleep)
user.follow(second_friend)