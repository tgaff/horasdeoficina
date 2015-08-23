FactoryGirl.define do
  factory :course do
    title "Rocket Science"

    factory :course_for_user do
      transient { user nil }
      transient { with_role :student }

      after(:create) do |course, evaluator|
        cp =
          if evaluator.with_role == :student
            create(:student_participant)
          elsif evaluator.with_role == :educator
            create(:educator_participant)
          end
        cp.user = evaluator.user
        course.course_participants << cp
      end
    end
  end
end
