class ClassParticipant < ActiveRecord::Base
  belongs_to :role
  has_many :weekly_time_blocks
  validates :role, presence: true
end
