class AddUserRefToCourseParticipants < ActiveRecord::Migration
  def change
    add_reference :course_participants, :user, index: true, foreign_key: true
  end
end
