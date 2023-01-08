FactoryBot.define do
  factory :sleep do
    association :user
    wake_up { 1.day.ago + 8.hours }
    created_at { 1.day.ago }
    # 8 hours in seconds
    duration { 28800 }

    trait :six_hours do
      wake_up { 1.day.ago + 6.hours }
      duration { 21600 }
    end
  end
end
