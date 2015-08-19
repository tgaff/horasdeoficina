class RenameClassParticipantColumnsToCourseParticipantColumns < ActiveRecord::Migration
  def change
    rename_column :weekly_time_blocks, :class_participant_id, :course_participant_id 
  end
end
