class Sleep < ApplicationRecord
  belongs_to :user
  before_create do
    self.bed = Time.now
  end
end
