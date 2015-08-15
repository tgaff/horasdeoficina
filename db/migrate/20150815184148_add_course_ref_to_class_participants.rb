class AddCourseRefToClassParticipants < ActiveRecord::Migration
  def change
    add_reference :class_participants, :course, index: true, foreign_key: true
  end
end
