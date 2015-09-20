# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string
#  locked_at              :datetime
#  created_at             :datetime
#  updated_at             :datetime
#

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
