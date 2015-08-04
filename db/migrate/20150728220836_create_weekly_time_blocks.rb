class CreateWeeklyTimeBlocks < ActiveRecord::Migration
  def change
    create_table :weekly_time_blocks do |t|
      t.string :dotw
      t.time :from
      t.time :to
      t.boolean :can
      t.integer :preferred
      t.references :class_participant, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
