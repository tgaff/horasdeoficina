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
