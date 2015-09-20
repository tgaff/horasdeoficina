# == Schema Information
#
# Table name: roles
#
#  id         :integer          not null, primary key
#  role_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :role do
    # TODO: consider generalizing the solution here for duplicates
    role_name "plebian"
    factory :student_role do
      role_name 'student'
      initialize_with { Role.student }
    end
    factory :educator_role do
      role_name 'educator' # note, this is only here as documentation
      initialize_with { Role.educator }
    end
  end
end
