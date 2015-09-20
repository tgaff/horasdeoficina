# == Schema Information
#
# Table name: courses
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Course, type: :model do
  it { should validate_presence_of :title }
  it { should have_many :course_participants }
  it { should have_many(:users).through :course_participants }
  it { should have_many(:weekly_time_blocks).through :course_participants }

  it 'is invalid if no title specified' do
    expect(FactoryGirl.build(:course, title: nil)).to_not be_valid
  end
  describe 'factory' do
    it 'is valid' do
      expect(FactoryGirl.build(:course)).to be_valid
    end
  end

end
