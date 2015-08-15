class Course < ActiveRecord::Base
  has_many :class_participants

  validates_presence_of :title
end
