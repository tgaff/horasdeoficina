require 'rails_helper'

RSpec.describe CourseParticipant, type: :model do
  subject(:course_participant) { FactoryGirl.create(:course_participant) }

  it { should be_valid }
  it { should respond_to(:role) }
  it { should belong_to(:role) }
  it { should validate_presence_of(:role) }
  it { should have_many(:weekly_time_blocks) }
  it { should belong_to(:course) }
  it { should validate_presence_of(:course) }

  describe 'fg traits' do
    it 'can be a student' do
      student = FactoryGirl.build(:course_participant, :student)
      expect(student).to be_valid
      expect(student.role.role_name).to eq 'student'
    end

    it 'can be an educator' do
      student = FactoryGirl.build(:course_participant, :educator)
      expect(student).to be_valid
      expect(student.role.role_name).to eq 'educator'
    end
  end
end
