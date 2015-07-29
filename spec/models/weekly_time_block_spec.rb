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

  describe 'participant with multiple time blocks' do
    let(:participant) { FactoryGirl.create(:class_participant) }
    before do
      FactoryGirl.create(:weekly_time_block, class_participant: participant,
                        from: '08:00', to: '13:00')
      FactoryGirl.create(:weekly_time_block, class_participant: participant,
                        from: '17:00', to: '22:00')
    end

    it 'cannot create a time-block that starts during another' do
      new_tb = FactoryGirl.build(:weekly_time_block, class_participant: participant,
                        from: '12:00', to: '15:00')
      expect(new_tb).to be_invalid
    end

    it 'cannot create a time-block that ends during another' do
      new_tb = FactoryGirl.build(:weekly_time_block, class_participant: participant,
                        from: '14:00', to: '18:00')
      expect(new_tb).to be_invalid
    end

    it 'can create a time-block that abuts others' do
      new_tb = FactoryGirl.build(:weekly_time_block, class_participant: participant,
                        from: '13:00', to: '17:00')
      expect(new_tb).to be_valid
    end

    it 'can create a time-block that overlaps others if not on the same day' do
      new_tb = FactoryGirl.build(:weekly_time_block, class_participant: participant,
                        from: '9:00', to: '18:00', dotw: 'Tuesday')
      expect(new_tb).to be_valid
    end

    it 'cannot create a time-block that completely contains another' do
      new_tb = FactoryGirl.build(:weekly_time_block, class_participant: participant,
                        from: '07:00', to: '23:00')
      expect(new_tb).to be_invalid
    end

  end
end
