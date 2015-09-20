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

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "g#{n}@g.com" }
    password "testtest"
    confirmed_at { Time.now }

    factory :unconfirmed_user do
      confirmed_at nil
    end

    trait :with_courses do
      transient { count 1 }
      transient { as_a :student }

      # note, always #create or none of this will exist
      # create a list of courses, then assign this user as a course_participant to each
      after(:create) do |user, evaluator|
        courses = create_list(:course, evaluator.count)
        courses.each do |course|
          if evaluator.as_a == :student
            create(:student_participant, course: course, user: user)
          else
            create(:educator_participant, course: course, user: user)
          end
        end
      end
    end

    factory :user_with_courses, traits: [:with_courses]

  end
end
