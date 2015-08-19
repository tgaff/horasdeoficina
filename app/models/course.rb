class Course < ActiveRecord::Base
  has_many :course_participants
  has_many :users, through: :course_participants
  validates_presence_of :title
end
