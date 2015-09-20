# == Schema Information
#
# Table name: weekly_time_blocks
#
#  id                    :integer          not null, primary key
#  from                  :datetime
#  to                    :datetime
#  can                   :boolean
#  preferred             :integer
#  course_participant_id :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

FactoryGirl.define do
  factory :weekly_time_block do
    from DateTime.new(2015,8,2,15,00)
    to DateTime.new(2015,8,2,17,00)
    can false
    preferred 1
    course_participant nil
  end
end
