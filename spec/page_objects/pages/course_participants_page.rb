class CourseParticipantsPage < SitePrism::Page
#  set_url 'course_participants/{:id}/'
  set_url '/course_participants'
  section :calendar, WeekCalendarSection, '#calendar'

  element :save_button, 'input[name="commit"]'

end
