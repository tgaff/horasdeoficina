# == Schema Information
#
# Table name: courses
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

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
        cp.save!
      end
    end

    # huge factory that generates an entire stack of courses with users and roles
    # please only use when really needed and in integration tests
    factory :course_with_many_users do
      transient { educators 2 }
      transient { students 3 }

      after(:create) do |course, evaluator|
        educator_users = create_list(:educator_participant,
                                evaluator.educators.to_i,
                                :with_new_user,
                                course: course
                               )
        student_users = create_list(:student_participant,
                               evaluator.students.to_i,
                               :with_new_user,
                               course: course
                              )
      end
    end
  end
  # build up a full deep hash from courses to users and roles
  factory :course_with_many_users_hash, class: Hash do
    transient { title 'Rocket Science' }
    after(:build) do |course, evaluator|
      participants = FactoryGirl.attributes_for_list(:student_role, 7)
      participants += FactoryGirl.attributes_for_list(:educator_role, 2)
      users = attributes_for_list(:user,9)
      participants.each_with_index do |part, index|
        part[:user] = users[index]
      end
      course[:course_participants] = participants
      course[:title] = evaluator.title
    end
  end
end
