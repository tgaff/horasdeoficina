# == Schema Information
#
# Table name: course_participants
#
#  id         :integer          not null, primary key
#  role_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  course_id  :integer
#  user_id    :integer
#

class CourseParticipant < ActiveRecord::Base
  belongs_to :role
  has_many :weekly_time_blocks
  belongs_to :course
  belongs_to :user
  validates :role, presence: true
  validates :course, presence: true

  scope :for_user, lambda { |user|
    where(user: user)
  }
end
