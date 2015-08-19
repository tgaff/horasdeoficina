class WeeklyTimeBlock < ActiveRecord::Base
  belongs_to :course_participant

  before_validation :morph_dates

  validates_presence_of :to, :from
  validate :must_be_valid_date_range
  validate :must_not_overlap_same_course_participant_times

  MINIMUM_VALID_DATE = DateTime.new(2015,8,1,23,59,59)
  MAXIMUM_VALID_DATE = DateTime.new(2015,8,9)

  def must_be_valid_date_range
    unless from.blank? || to.blank? # presence validation covers this
      if from < MINIMUM_VALID_DATE
        errors.add :from, "from occurs before #{MINIMUM_VALID_DATE}"
      end
      if to > MAXIMUM_VALID_DATE
        errors.add :to, "to occurs after #{MAXIMUM_VALID_DATE}"
      end
      if from >= to
        errors.add :to, "is the same or less than from, the date range is zero or negative length"
      end
    end
  end
  def must_not_overlap_same_course_participant_times
    unless course_participant.blank?
      time_blocks = WeeklyTimeBlock.where course_participant: course_participant
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

  private

  # 2015-08-02 is our official week we use for everything (rails doesn't have a format for dotw)
  # sets self.from and self.to to have the same time but in the week beginning 2015-08-02
  def morph_dates
    unless self[:from].blank? || self[:to].blank?
      [:from, :to].each do |attr|
        this_date = self[attr]
        day_num = get_date_for_dotw(this_date)
        self[attr] = DateTime.new(2015, 8, day_num, this_date.hour, this_date.min)
      end
      # reset anything that extends over the saturday boundary to end that day :-/
      if self[:to].day > 8 || self[:to] < self[:from]
        self[:to] = DateTime.new(2015, 8, 8, 23, 59)
      end
    end
  end


  # finds a date in 2015-08-02 through 2015-08-09 that matches the day of the week from the provided date
  def get_date_for_dotw(some_dotw)
    (2..10).find { |digit| DateTime.new(2015,8,digit).strftime('%A') == some_dotw.strftime('%A') }
  end
end
