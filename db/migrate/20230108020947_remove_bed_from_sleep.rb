class RemoveBedFromSleep < ActiveRecord::Migration[7.0]
  def change
    remove_column :sleeps, :bed, :datetime
  end
end
