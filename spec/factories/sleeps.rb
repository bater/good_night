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

    trait :ten_hours do
      wake_up { 1.day.ago + 10.hours }
      duration { 36000 }
    end

    trait :past_2_weeks do
      wake_up { 2.weeks.ago + 8.hours }
      created_at { 2.weeks.ago }
    end

    trait :just_in_bed do
      wake_up { nil }
      duration { 0 }
    end
  end
end
