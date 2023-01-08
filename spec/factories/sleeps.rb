FactoryBot.define do
  factory :sleep do
    association :user
    sequence(:wake_up) { |n| n.day.ago + 8.hours }
    sequence(:created_at) { |n| n.day.ago }
  end
end
