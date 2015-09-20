# == Schema Information
#
# Table name: roles
#
#  id         :integer          not null, primary key
#  role_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

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
    it 'returns an instace of the model' do
      expect(Role::educator).to be_a Role
    end
    it 'finds the "student" role' do
      expect(Role::educator.role_name).to eq 'educator'
    end
    it 'creates is if it doesnt exist' do
      expect { Role.educator }.to change { Role.all.count }
    end
    it "doesn't create it if it does exist" do
      Role.educator
      expect { Role.educator }.to_not change { Role.all.count }
    end
  end

  describe '::student' do
    it 'returns an instace of the model' do
      expect(Role::student).to be_a Role
    end
    it 'finds the "student" role' do
      expect(Role::student.role_name).to eq 'student'
    end
    it 'creates it if it doesnt exist' do
      expect { Role.student }.to change { Role.all.count }
    end
    it "doesn't create a new one if it already exists " do
      Role.student
      expect { Role.student }.to_not change { Role.all.count }
    end
  end
end
