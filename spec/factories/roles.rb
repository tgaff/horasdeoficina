FactoryGirl.define do
  factory :role do
    role_name "plebian"
    factory :student_role do
      role_name 'student'
      initialize_with { Role.student }
    end
    factory :educator_role do
      role_name 'educator'
    end
  end
end
