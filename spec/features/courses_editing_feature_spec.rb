require 'rails_helper'

RSpec.feature "Editing courses",
  %q{
    As a teacher or student,
    I want to edit the courses I'm involved in,
},
  :js do


  given!(:course) { FactoryGirl.create(:course_with_many_users, students: 3) } # a huge factory
  given(:teacher) { course.course_participants.where( role: Role.educator ).first.user }
  given(:one_student) { course.course_participants.where(role: Role.student).first.user }

  before do
    UsersSignInPage.sign_in_user(teacher.email)
    @p = CoursesIndexPage.new
    @p.load
    @p.teaching_courses.first.edit_link.click
    @p = CoursesEditPage.new
  end

  it 'displays the page elements', :focus do # verify the page-object ?
    expect(@p).to be_displayed
    expect(@p).to be_all_there
  end

  scenario "changing the course name" do
    @p.title_field.set 'Saving Christmas'
    @p.update_button.click
    @p = CoursesIndexPage.new
    expect(@p).to be_displayed
    expect(@p.teaching_courses_table).to have_content 'Saving Christmas'
  end

  scenario 'shows us the course participants broken into educators and students' do
    expect(@p.students.count).to eq 3
    expect(@p.educators.count).to eq 2
  end

  scenario 'can proceed to view my calendar' do
    @p.edit_calendar_link.click
    @p = CourseParticipantsPage.new
    expect(@p).to be_displayed
  end
end
