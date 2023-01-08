require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe "GET /follow" do
    let(:friend) { FactoryBot.create(:user) }
    it "returns http success" do
      get "/user/#{user.id}/follow/#{friend.id}"
      expect(response).to have_http_status(:success)
    end
    it "friend doesn't exist"
  end

  describe "GET /unfollow" do
    let(:user) { FactoryBot.create(:user, :has_friend) }
    let(:friend) { user.friendships.first }
    it "returns http success" do
      get "/user/#{user.id}/unfollow/#{friend.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /go_to_bed" do
    it "returns http success" do
      get "/user/#{user.id}/go_to_bed"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /wake_up" do
    it "returns http success" do
      user.go_to_bed
      get "/user/#{user.id}/wake_up"
      expect(response).to have_http_status(:success)
    end
    it "user wake up twice"
    it "user never sleep"
  end

  describe "GET /sleeps" do
    before do
      get "/user/#{user.id}/sleeps"
    end
    let(:user) { FactoryBot.create(:user, :with_sleeps) }
    it "returns sleeps data" do
      expect(json.size).to eq(3)
    end
    it "return http success" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /friends" do
    before do
      get "/user/#{user.id}/friends"
    end
    let(:user) { FactoryBot.create(:user, :has_friend) }
    it "returns friend data" do
      expect(json.first['name']).to eq(user.friendships.first.name)
    end
    it "return http success" do
      expect(response).to have_http_status(:success)
    end
  end
end
