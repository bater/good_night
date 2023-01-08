require 'rails_helper'

RSpec.describe Sleep, type: :model do
  describe "#bed" do
    let(:sleep) { FactoryBot.create(:sleep) }
    it "bed is created at time" do
      expect(sleep.bed).to eq sleep.created_at
    end
  end

  describe "#duration" do
    include_context 'time freeze'
    let(:sleep) { FactoryBot.create(:sleep, :just_in_bed) }
    before do
      sleep.update(wake_up: 1.day.ago + 8.hours)
    end
    it "user wake up" do
      expect(sleep.wake_up.to_s).to eq "2022-12-31 08:00:00 +0900"
      expect(sleep.duration).to eq 28800
    end
  end
end
