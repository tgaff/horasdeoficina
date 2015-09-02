require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the CoursesHelper. For example:
#
# describe CoursesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe CoursesHelper, type: :helper do

  let(:user) { FactoryGirl.create(:user_with_courses, as_a: :student) }

  before(:each) do
    sign_in user
    @courses = FactoryGirl.create_list(:course, 2)
    sp  = FactoryGirl.create(:student_participant, course: @courses.first, user: user)
    tp  = FactoryGirl.create(:educator_participant, course: @courses.last, user: user)
  end

  describe '#as_an_educator' do
    it "returns only the courses that have a role of 'educator'" do
      res = helper.as_an_educator(@courses)
      expect(res.count).to eq 1
      expect(res.first.course_participants.first.role.role_name).to eq 'educator'
    end

    # Test for issue where the role checked could be from another user's course_participant
    it "uses the current_user's role in the course for scoping" do
      course3 = FactoryGirl.create(:course)
      other_role = :educator_participant
      FactoryGirl.create(other_role, course: course3) # with a nil user
      this_cp = FactoryGirl.create(:student_participant, course:course3, user: user) # add this user in the middle of the list
      FactoryGirl.create_list(other_role, 2, course: course3) #end with other users
      @courses << course3
      res = helper.as_an_educator(@courses)

      expect(res.count).to eq 1

      # verify that it changes when we change the cp in the middle
      this_cp.update_attribute(:role, Role.educator)
      res = helper.as_an_educator(@courses)
      expect(res.count).to eq 2
    end

  end

  describe '#as_a_student' do
    it "returns only the courses that have a role of 'student'" do
      res = helper.as_a_student(@courses)
      expect(res.count).to eq 1
      expect(res.first.course_participants.first.role.role_name).to eq 'student'
    end

    # Test for issue where the role checked could be from another user's course_participant
    it "uses the student and the students role in the course for scoping" do
      course3 = FactoryGirl.create(:course)
      FactoryGirl.create(:student_participant, course: course3) # with a nil user
      FactoryGirl.create(:educator_participant, course:course3, user: user) # add this user in the middle of the list
      FactoryGirl.create_list(:student_participant, 2, course: course3) #end with other users
      @courses << course3
      res = helper.as_a_student(@courses)

      expect(res.count).to eq 1

      user.course_participants.each { |cp| cp.role = Role.student; cp.save! }
      res = helper.as_a_student(@courses)
      expect(res.count).to eq 3
    end
  end

  describe '#user_courses_by_role' do
    let(:student) { FactoryGirl.create(:user) }
    let(:teacher) { FactoryGirl.create(:user) }
    let(:course) { FactoryGirl.create(:course_for_user, user: student) }
    before { FactoryGirl.create(:educator_participant, course: course, user: teacher) }
    subject(:result) { helper.user_courses_by_type(course) }
    it 'returns a hash with keys :students, :teachers, :other' do
      expect(result).to be_a Hash
      expect(result.keys) =~ [ :students, :teachers, :other ]
    end
    it 'has an array of students in the students hash' do
      expect(result[:students]).to be_an Array
      expect(result[:students].first.email).to eq student.email
    end

    it 'has an array of educators under the educators keys' do
      expect(result[:educators]).to be_an Array
      expect(result[:educators].first.email).to eq teacher.email
    end

  end
end
