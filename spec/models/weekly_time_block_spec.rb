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

require 'rails_helper'

RSpec.describe WeeklyTimeBlock, type: :model do
  subject(:weekly_time_block) { FactoryGirl.build(:weekly_time_block) }

  it { should be_valid }
  it { should belong_to :course_participant }

  it { should validate_presence_of :from }
  it { should validate_presence_of :to }

  describe '#morph_dates to week of 2015-08-02' do
    time_chunks = [
      { from: DateTime.new(1999,8,3, 11,00), to: DateTime.new(1999,8,3, 12,00) },
      { from: DateTime.new(2016,8,3, 11,00), to: DateTime.new(2016,8,3, 12,00) },
      { from: DateTime.new(2015,8,3, 11,00), to: DateTime.new(2015,8,3, 12,00) },
      { from: DateTime.new(2015,8,3, 11,00), to: DateTime.new(2015,8,5, 12,00) },
      { from: DateTime.new(2015,8,8, 11,00), to: DateTime.new(2015,8,8, 12,00) },
      { from: DateTime.new(2015,8,8, 11,00), to: DateTime.new(2015,8,9, 0,01),
        morphed_to: DateTime.new(2015,8,8,23,59)}, # special case crosses week boundary on :to
      { from: DateTime.new(2015,8,1, 23,58), to: DateTime.new(2015,8,2, 1,00),
        morphed_to: DateTime.new(2015,8,8,23,59)},
    ]
    time_chunks.each do |range|
      describe "for range #{range[:from]}-#{range[:to]}" do
        subject(:wtb) { FactoryGirl.create(:weekly_time_block, from: range[:from], to: range[:to]) }
        it "morphs from value" do
          expect(wtb.from.year).to eq 2015
          expect(wtb.from.month).to eq 8
          expect(wtb.from.day).to be >= 2
          expect(wtb.from.day).to be <= 8
        end
        it "morphs to value" do
          expect(wtb.to.year).to eq 2015
          expect(wtb.to.month).to eq 8
          expect(wtb.to.day).to be >= 2
          expect(wtb.to.day).to be <= 8
        end
        it "from keeps the day of the week" do
          expect(wtb.from.strftime('%A')).to eq range[:from].strftime('%A')
        end
        it "to keeps the day of the week (when possible)" do
          if range[:morphed_to]
            expect(wtb.to.strftime('%A')).to eq 'Saturday'
          else
            expect(wtb.to.strftime('%A')).to eq range[:to].strftime('%A')
          end
        end
        it "maintains the distance between from and to (when possible)" do
          if range[:morphed_to]
            expect(wtb.to).to eq range[:morphed_to]
          else
            # note the wtb.to.time conversion to a Time or DateTime here
            # http://api.rubyonrails.org/classes/ActiveSupport/TimeWithZone.html#method-i-time
            expect(wtb.to.time - wtb.from.time).to eq range[:to]-range[:from]
          end
        end
      end
    end
  end
  describe 'participant with multiple time blocks' do
    let(:participant) { FactoryGirl.create(:course_participant) }
    before do
      FactoryGirl.create(:weekly_time_block, course_participant: participant,
                         from: DateTime.new(2015,8,2,11), to: DateTime.new(2015,8,2,13))
      FactoryGirl.create(:weekly_time_block, course_participant: participant,
                         from: DateTime.new(2015,8,2,17), to: DateTime.new(2015,8,2,22))
    end

    it 'cannot create a time-block that starts during another' do
      new_tb = FactoryGirl.build(:weekly_time_block,
                                 course_participant: participant,
                                 from: DateTime.new(2015,8,2,12,00),
                                 to: DateTime.new(2015,8,2,14)
                                )
      expect(new_tb).to be_invalid
    end

    it 'cannot create a time-block that ends during another' do
      new_tb = FactoryGirl.build(:weekly_time_block,
                                 course_participant: participant,
                                 from: DateTime.new(2015,8,2,14),
                                 to: DateTime.new(2015,8,2,19)
                                )
      expect(new_tb).to be_invalid
    end

    it 'can create a time-block that abuts others' do
      new_tb = FactoryGirl.build(:weekly_time_block, course_participant: participant,
                        from: '13:00', to: '17:00')
      expect(new_tb).to be_valid
    end

    it 'can create a time-block that overlaps others if not on the same day' do
      new_tb = FactoryGirl.build(:weekly_time_block, course_participant: participant,
                                 from: DateTime.new(2015, 8, 5, 9), to: DateTime.new(2015, 8, 5, 18))
      expect(new_tb).to be_valid
    end

    it 'cannot create a time-block that completely contains another' do
      new_tb = FactoryGirl.build(:weekly_time_block,
                                 course_participant: participant,
                                 from: DateTime.new(2015,8,2,1),
                                 to: DateTime.new(2015,8,2,23)
                                 )
      expect(new_tb).to be_invalid
    end

  end
end
