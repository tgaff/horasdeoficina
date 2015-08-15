require 'rails_helper'

RSpec.describe Course, type: :model do
  it { should validate_presence_of :title }
  it { should have_many :class_participants }

  it 'is invalid if no title specified' do
    expect(FactoryGirl.build(:course, title: nil)).to_not be_valid
  end
  describe 'factory' do
    it 'is valid' do
      expect(FactoryGirl.build(:course)).to be_valid
    end
  end

end
