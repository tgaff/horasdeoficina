class RenameClassParticipantToCourseParticipant < ActiveRecord::Migration
  def change
    rename_table :class_participants, :course_participants
  end
end
