# == Schema Information
#
# Table name: course_participants
#
#  id         :integer          not null, primary key
#  role_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  course_id  :integer
#  user_id    :integer
#

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
  it { should belong_to(:user) }

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

  describe 'scope for_user' do
    let(:user) { FactoryGirl.create(:user) }
    let(:cps) { FactoryGirl.build_list(:student_participant, 5) }
    before { cps[2].update_attributes(user: user) }
    it 'returns only the records assigned to a particular user' do
      expect(CourseParticipant.for_user(user).count).to eq 1
      expect(CourseParticipant.for_user(403883900).count).to eq 0
    end
  end
end
