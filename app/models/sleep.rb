class Sleep < ApplicationRecord
  belongs_to :user
  before_save :count_duration_seconds, if: :wake_up_changed?

  default_scope { order("created_at DESC") }
  scope :past_week, -> { where("created_at >= ?", 1.week.ago) }

  def bed
    created_at
  end

  def record
    {
      bed: bed.to_s,
      wake_up: wake_up.to_s
    }
  end

  private

  def count_duration_seconds
    self.duration = (wake_up - bed).round
  end
end
