require 'rails_helper'

RSpec.describe User, type: :model do

  subject(:user) { FactoryGirl.create(:user) }

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should be_valid }
  it { should have_many(:course_participants) }
  it { should have_many(:courses).through(:course_participants) }

  it 'is invalid without an email' do
    user = User.new(password: '12345678', password_confirmation: '12345678')
    expect(user).to be_invalid
    expect(user.errors.messages).to have_key :email
  end

  it 'is invalid without a password' do
    user = FactoryGirl.build(:user)
    user.password = nil
    expect(user).to be_invalid
    expect(user.errors.messages).to have_key :password
  end

  it 'is invalid if the password confirmation does not match' do
    user = FactoryGirl.build(:user, password_confirmation: 'dskjldksjfklsjf')
    expect(user).to be_invalid
  end
end
