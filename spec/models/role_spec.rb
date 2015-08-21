require 'rails_helper'

RSpec.describe Role, type: :model do

  subject(:role) { FactoryGirl.create(:role) }

  it { should be_valid }
  it { should have_many :course_participants }
  it { should validate_presence_of :role_name }
  it { should validate_uniqueness_of(:role_name).case_insensitive }

  it 'converts role_names to lowercase' do
    role.role_name = 'AbCd'
    expect{role.save}.to change{role.role_name}.from('AbCd').to('abcd')
  end

  describe '::educator' do
    before { FactoryGirl.create :educator }
    it 'returns an instace of the model' do
      expect(Role::educator).to be_a Role
    end
    it 'finds the "student" role' do
      expect(Role::educator.role_name).to eq 'educator'
    end
  end

  describe '::student' do
    before { FactoryGirl.create :student_role }
    it 'returns an instace of the model' do
      expect(Role::student).to be_a Role
    end
    it 'finds the "student" role' do
      expect(Role::student.role_name).to eq 'student'
    end
  end
end
