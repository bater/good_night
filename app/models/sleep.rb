class Sleep < ApplicationRecord
  belongs_to :user

  def bed
    created_at
  end
end
