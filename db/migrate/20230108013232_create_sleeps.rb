class CreateSleeps < ActiveRecord::Migration[7.0]
  def change
    create_table :sleeps do |t|
      t.belongs_to :user, foreign_key: true
      t.datetime :bed
      t.datetime :wake_up

      t.timestamps
    end
  end
end
