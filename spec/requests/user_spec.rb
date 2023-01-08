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
end
