require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }

  describe "#follow" do
    let(:friend) { FactoryBot.create(:user) }
    before { user.follow(friend) }
    it "User can follow a friend" do
      expect(user.friendship_ids).to include friend.id
    end
  end

  describe "#unfollow" do
    let(:user) { FactoryBot.create(:user, :has_friend) }
    let(:friend) { user.friendships.first }
    before { user.unfollow(friend) }
    it "User can follow a friend" do
      expect(user.friendship_ids).not_to include friend.id
    end
  end

  describe "#go_to_bed" do
    include_context 'time freeze'
    it "user go to bed" do
      user.go_to_bed
      expect(user.sleeps.last.bed.to_s).to eq Time.parse("2023/1/1").to_s
    end
  end

  describe "#wake_up" do
    include_context 'time freeze'
    it "user wake up" do
      user.go_to_bed
      Timecop.travel(Time.local(2023, 1, 2))
      user.wake_up
      expect(user.sleeps.last.wake_up.to_s).to eq Time.parse("2023/1/2").to_s
    end
    describe "user neven sleep" do
      let(:user) { FactoryBot.create(:user) }
      it "Do nothing" do
        expect(user.wake_up).to be nil
        expect(user.sleeps.size).to be 0
      end
    end
  end

  describe "#personal_sleeps" do
    let(:user) { FactoryBot.create(:user, :with_sleeps) }
    it "order by created_at DESC" do
      expect(user.personal_sleeps.first[:bed]).to eq user.sleeps.first.bed.to_s
    end
  end

  describe "#friends_record" do
    let(:user) { FactoryBot.create(:user, :has_friend) }
    let(:friend) { user.friendships.first }
    before do
      FactoryBot.create(:sleep, user_id: friend.id)
    end
    it "can see friend's name" do
      expect(user.friends_record.first[:name]).to eq friend.name
    end
    it "can see friend's sleep record" do
      expect(user.friends_record.first[:record].first[:bed]).to eq friend.sleeps.last.bed.to_s
    end
    it "can see friend's total sleep length of past week" do
      expect(user.friends_record.first[:length]).to eq (8 * 60 * 60)
    end
    context "ordered by length of their friends" do
      let(:friend_sleep_more) { FactoryBot.create(:user, :with_10_hours_sleep) }
      let(:friend_sleep_less) { FactoryBot.create(:user, :with_6_hours_sleep) }
      before do
        user.follow(friend_sleep_more)
        user.follow(friend_sleep_less)
      end
      it "First firend sleep lenth bigger than last friend" do
        expect(user.friends_record.size).to eq 3
        expect(user.friends_record.first[:length]).to eq 36000
        expect(user.friends_record.last[:length]).to eq 21600
      end
    end
    context "Only include past week sleep data" do
      before do
        FactoryBot.create(:sleep, :past_2_weeks, user_id: friend.id)
      end
      it "Only include 1 sleep record" do
        expect(user.friends_record.size).to eq 1
        expect(user.friends_record.first[:length]).to eq 28800
      end
    end
  end

  describe "#batch_sleep_data" do
    let(:friend_a) { FactoryBot.create(:user) }
    let(:friend_b) { FactoryBot.create(:user) }
    let(:sleep_1) { FactoryBot.create(:sleep, created_at: 1.day.ago, wake_up: 1.day.ago + 8.hours, user_id: friend_a.id) }
    let(:sleep_2) { FactoryBot.create(:sleep, created_at: 2.days.ago, wake_up: 2.days.ago + 8.hours, user_id: friend_b.id) }
    let(:sleep_3) { FactoryBot.create(:sleep, created_at: 3.days.ago, wake_up: 3.days.ago + 8.hours, user_id: friend_a.id) }
    let(:sleep_4) { FactoryBot.create(:sleep, created_at: 4.days.ago, wake_up: 4.days.ago + 8.hours, user_id: friend_b.id) }
    before do
      user.follow(friend_a)
      user.follow(friend_b)
    end
    describe "get all target sleeps with order" do
      it do
        sleep_1
        sleep_2
        sleep_3
        sleep_4
        expect(user.send(:batch_sleep_data).size).to eq 4
        expect(user.send(:batch_sleep_data).first).to eq sleep_1
        expect(user.send(:batch_sleep_data).second).to eq sleep_2
        expect(user.send(:batch_sleep_data).third).to eq sleep_3
        expect(user.send(:batch_sleep_data).last).to eq sleep_4
      end
    end
  end
end
