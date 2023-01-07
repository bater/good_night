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
end
