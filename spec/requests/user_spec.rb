require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe "GET /follow" do
    let(:friend) { FactoryBot.create(:user) }
    it "returns http success" do
      get "/user/#{user.id}/follow/#{friend.id}"
      expect(response).to have_http_status(:success)
    end
    it "user doesn't exist (999)" do
      get "/user/999/follow/#{friend.id}"
      expect(response).to have_http_status(404)
    end
    it "friend doesn't exist (999)" do
      get "/user/#{user.id}/follow/999"
      expect(response).to have_http_status(404)
    end
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
    describe "user never sleep" do
      let(:user) { FactoryBot.create(:user) }
      it do
        get "/user/#{user.id}/wake_up"
        expect(response).to have_http_status(:success)
      end
    end
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
      user.follow(friend1)
      user.follow(friend2)
      get "/user/#{user.id}/friends"
    end
    let(:friend1) { FactoryBot.create(:user, :with_6_hours_sleep) }
    let(:friend2) { FactoryBot.create(:user, :with_10_hours_sleep) }
    it "returns friend data" do
      expect(json.first['name']).to eq(friend2.name)
      expect(json.first['length']).to eq(36000)
      expect(json.last['length']).to eq(21600)
      expect(json.first.keys).to match_array(%w[name record length])
    end
    it "return http success" do
      expect(response).to have_http_status(:success)
    end
  end
end
