FactoryGirl.define do
  factory :course_participant do
    role
    course

    trait :student do
      association :role, factory: :student_role
    end

    trait :educator do
      association :role, factory: :educator_role
    end

    factory :student_participant, traits: [:student]
    factory :educator_participant, traits: [:educator]
  end

end
