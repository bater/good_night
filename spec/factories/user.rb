FactoryBot.define do
  factory :user, class: User do
    name { Faker::Name.name }

    trait :has_friend do
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

    trait :with_6_hours_sleep do
      after(:create) do |user|
        create(:sleep, :six_hours, user_id: user.id)
      end
    end

    trait :with_10_hours_sleep do
      after(:create) do |user|
        create(:sleep, :ten_hours, user_id: user.id)
      end
    end
  end
end
