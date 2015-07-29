require 'rails_helper'

RSpec.describe Role, type: :model do

  subject(:role) { FactoryGirl.create(:role) }

  it { should be_valid }
  it { should have_many :class_participants }
  it { should validate_presence_of :role_name }
  it { should validate_uniqueness_of(:role_name).case_insensitive }

  it 'converts role_names to lowercase' do
    role.role_name = 'AbCd'
    expect{role.save}.to change{role.role_name}.from('AbCd').to('abcd')
  end
end
