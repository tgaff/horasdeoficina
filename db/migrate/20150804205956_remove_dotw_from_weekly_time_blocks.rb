class RemoveDotwFromWeeklyTimeBlocks < ActiveRecord::Migration
  def up
    remove_column :weekly_time_blocks, :dotw
  end
  def down
    add_column :weekly_time_blocks, :dotw, :string
  end
end
