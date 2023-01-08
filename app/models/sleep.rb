class Sleep < ApplicationRecord
  belongs_to :user
  default_scope { order("created_at DESC") }

  def bed
    created_at
  end
end
