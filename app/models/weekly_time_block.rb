class WeeklyTimeBlock < ActiveRecord::Base
  belongs_to :class_participant

  validates :dotw, presence: true
  validates_presence_of :to, :from
  validates :dotw, inclusion: { in: Date::DAYNAMES }

end
