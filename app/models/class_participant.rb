class ClassParticipant < ActiveRecord::Base
  belongs_to :role
  validates :role, presence: true
end
