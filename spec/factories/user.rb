FactoryBot.define do
  factory :user, class: User do
    factory :user_has_friend do
      after(:create) do |user|
        friend = create(:user)
        user.follow(friend)
      end
    end
  end
end
