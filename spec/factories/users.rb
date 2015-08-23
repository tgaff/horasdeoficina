FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "g#{n}@g.com" }
    password "12345678"
    confirmed_at { Time.now }

    factory :unconfirmed_user do
      confirmed_at nil
    end

    trait :with_courses do
      transient { count 1 }

      # note, always #create or none of this will exist
      # create a list of courses, then assign this user as a course_participant to each
      after(:create) do |user, evaluator|
        courses = create_list(:course, evaluator.count)
        courses.each do |course|
          create(:student_participant, course: course, user: user)
        end
      end
    end
  end
end
