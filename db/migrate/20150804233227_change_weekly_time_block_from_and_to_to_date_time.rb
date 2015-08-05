class ChangeWeeklyTimeBlockFromAndToToDateTime < ActiveRecord::Migration
  def up
    change_column :weekly_time_blocks, :from, :datetime
    change_column :weekly_time_blocks, :to, :datetime
  end
  def down
    change_column :weekly_time_blocks, :from, :time
    change_column :weekly_time_blocks, :to, :time
  end
end
