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

    trait :past_2_weeks do
      wake_up { 2.weeks.ago + 8.hours }
      created_at { 2.weeks.ago }
    end
  end
end
