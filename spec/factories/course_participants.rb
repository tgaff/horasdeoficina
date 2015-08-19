FactoryGirl.define do
  factory :course_participant do
    role
    course

    trait :student do
      association :role, role_name: 'student'
    end


    trait :educator do
      association :role, role_name: 'educator'
    end

  end

end
