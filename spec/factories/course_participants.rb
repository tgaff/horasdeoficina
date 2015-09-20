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

FactoryGirl.define do
  factory :course_participant do
    role
    course
    user

    trait :student do
      association :role, factory: :student_role
    end

    trait :educator do
      association :role, factory: :educator_role
    end

    trait :with_new_user do
      association :user, factory: :user
    end

    factory :student_participant, traits: [:student]
    factory :educator_participant, traits: [:educator]
  end

end
