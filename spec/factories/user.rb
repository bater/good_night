FactoryBot.define do
  factory :user, class: User do
    factory :user_has_friend do
      after(:create) do |user|
        friend = create(:user)
        user.follow(friend)
      end
    end

    trait :with_sleeps do
      after(:create) do |user|
        create_list(:sleep, 3, user_id: user.id)
      end
    end
  end
end
