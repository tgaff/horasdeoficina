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
  before(:each) do
    @courses = FactoryGirl.create_list(:course, 2)
    sp  = FactoryGirl.create(:student_participant, course: @courses.first)
    tp  = FactoryGirl.create(:educator_participant, course: @courses.last)
  end

  describe '#as_an_educator' do
    it "returns only the courses that have a role of 'educator'" do
      res = helper.as_an_educator(@courses)
      expect(res.count).to eq 1
      expect(res.first.course_participants.first.role.role_name).to eq 'educator'
    end
  end

  describe '#as_a_student' do
    it "returns only the courses that have a role of 'student'" do
      res = helper.as_a_student(@courses)
      expect(res.count).to eq 1
      expect(res.first.course_participants.first.role.role_name).to eq 'student'
    end
  end
end
