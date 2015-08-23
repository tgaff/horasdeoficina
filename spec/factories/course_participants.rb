FactoryGirl.define do
  factory :course_participant do
    role
    course

    trait :student do
      association :role, factory: :student_role
    end

    trait :educator do
      association :role, :role, role_name: 'educator'
    end
    factory :student_participant, traits: [:student]
  end

end
