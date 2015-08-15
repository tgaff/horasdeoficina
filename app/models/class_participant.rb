class ClassParticipant < ActiveRecord::Base
  belongs_to :role
  has_many :weekly_time_blocks
  belongs_to :course
  validates :role, presence: true
  validates :course, presence: true
end
