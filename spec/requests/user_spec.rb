require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /follow" do
    let(:user) { FactoryBot.create(:user) }
    let(:friend) { FactoryBot.create(:user) }
    it "returns http success" do
      get "/user/#{user.id}/follow/#{friend.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /unfollow" do
    let(:user) { FactoryBot.create(:user_has_friend) }
    let(:friend) { user.friendships.first }
    it "returns http success" do
      get "/user/#{user.id}/unfollow/#{friend.id}"
      expect(response).to have_http_status(:success)
    end
  end
end
