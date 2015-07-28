require 'rails_helper'

RSpec.describe WeeklyTimeBlock, type: :model do
  subject(:weekly_time_block) { FactoryGirl.build(:weekly_time_block) }

  it { should be_valid }
  it { should belong_to :class_participant }
  it { should validate_presence_of :dotw }

  it { should validate_presence_of :from }
  it { should validate_presence_of :to }

  let(:days_of_the_week) { [ 'Sunday', 'Monday',
                             'Tuesday', 'Wednesday',
                              'Thursday', 'Friday',
                              'Saturday'
  ] }

  it 'allows valid days of the week' do
    days_of_the_week.each do |d|
      expect(FactoryGirl.build(:weekly_time_block, dotw: d) ).to be_valid
    end
  end
  it 'doesnt permit days of the week from other planets' do
    expect(FactoryGirl.build(:weekly_time_block, dotw: 'Towelday') ).to be_invalid
  end
end
