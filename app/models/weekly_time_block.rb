class WeeklyTimeBlock < ActiveRecord::Base
  belongs_to :class_participant

  validates :dotw, presence: true
  validates_presence_of :to, :from
  validates :dotw, inclusion: { in: Date::DAYNAMES }
  validate :must_not_overlap_same_class_participant_times

  def must_not_overlap_same_class_participant_times
    unless class_participant.blank?
      time_blocks = WeeklyTimeBlock.where class_participant: class_participant,
        dotw: dotw
      # beginning starts during another ( [ )  ]
      time_blocks.each do |time_block|
        if time_is_between?(from, time_block.from, time_block.to)
          errors.add(:from, "from occurs during another time-block scheduled from\
                     #{time_block.from} to #{time_block.to}.")
        end
        # end extends into another [  (]  )
        if time_is_between?(to, time_block.from, time_block.to)
          errors.add(:to, "to occurs during another time-block scheduled from\
                     #{time_block.from} to #{time_block.to}.")
        end
        # completely contains another [  ( )  ]
        if from < time_block.from && to > time_block.to
          errors.add(:to, "time block subsumes another time-block scheduled from\
                     #{time_block.from} to #{time_block.to}.")
        end

      end
    end
  end

  def time_is_between?(time, beginning, ending)
    time > beginning && time < ending
  end
end
