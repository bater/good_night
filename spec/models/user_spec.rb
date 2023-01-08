require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#follow" do
    let(:user) { FactoryBot.create(:user) }
    let(:friend) { FactoryBot.create(:user) }
    before { user.follow(friend) }
    it "User can follow a friend" do
      expect(user.friendship_ids).to include friend.id
    end
  end

  describe "#unfollow" do
    let(:user) { FactoryBot.create(:user_has_friend) }
    let(:friend) { user.friendships.first }
    before { user.unfollow(friend) }
    it "User can follow a friend" do
      expect(user.friendship_ids).not_to include friend.id
    end
  end

  describe "#go_to_bed" do
    before do
      Timecop.freeze(Time.local(2023, 1, 1))
    end
    let(:user) { FactoryBot.create(:user) }
    it "user go to bed" do
      user.go_to_bed
      expect(user.sleep.last.bed).to eq Time.parse("2023/1/1")
    end
  end
end
