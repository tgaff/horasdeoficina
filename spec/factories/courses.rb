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
