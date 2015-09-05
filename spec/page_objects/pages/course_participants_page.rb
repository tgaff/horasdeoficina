class CourseParticipantsPage < SitePrism::Page
#  set_url 'course_participants/{:id}/'
  set_url '/courses/{:course_id}/calendar'
  set_url_matcher /courses.*\/calendar/

  section :calendar, WeekCalendarSection, '#calendar'

  element :save_button, 'input[name="commit"]'
  section :course_name_dropdown, '.page-header a' do
    element :edit_link, 'a', text: 'edit course'
  end

  def navigate_here
    visit '/'
    page = CoursesIndexPage.new
    page.all_courses.first.edit_calendar_link.click
    self
  end

  def self.navigate_here
    page = self.new
    page.navigate_here
  end
end

