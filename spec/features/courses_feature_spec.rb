require 'rails_helper'

RSpec.feature "Courses",
  %q{
    As a teacher or student,
    I want to have a listing of courses I'm involved in
  },
  :js do

  let(:student_user) { FactoryGirl.create(:user, :with_courses, count: 2, as_a: :student) }
  let(:educator_user) { FactoryGirl.create(:user, :with_courses, count: 3, as_a: :educator) }

  scenario 'displays the list of courses for an educator' do
    UsersSignInPage.sign_in_user(educator_user.email)
    p = CoursesIndexPage.new
    p.load
    expect((p.teaching_courses text: 'Rocket Science').count).to eq 3
  end

   scenario 'displays the list of courses for a student' do
    UsersSignInPage.sign_in_user(student_user.email)
    p = CoursesIndexPage.new
    p.load
    expect((p.learning_courses text: 'Rocket Science').count).to eq 2
    binding.pry
    puts ''
  end

  scenario 'test' do
    UsersSignInPage.sign_in_user(student_user.email)
    p = CoursesIndexPage.new
    p2 = CoursesIndexPage.new
    p.load
    binding.pry
    puts ''
  end

end
