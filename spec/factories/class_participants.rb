FactoryGirl.define do
  factory :class_participant do
    role

    trait :student do
      association :role, role_name: 'student'
    end


    trait :educator do
      association :role, role_name: 'educator'
    end

  end

end
