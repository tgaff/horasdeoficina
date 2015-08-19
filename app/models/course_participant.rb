class CourseParticipant < ActiveRecord::Base
  belongs_to :role
  has_many :weekly_time_blocks
  belongs_to :course
  belongs_to :user
  validates :role, presence: true
  validates :course, presence: true

end
