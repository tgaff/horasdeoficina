class ClassParticipantsPage < SitePrism::Page
#  set_url 'class_participants/{:id}/'
  set_url '/class_participants'
  section :calendar, WeekCalendarSection, '#calendar'

  element :save_button, 'input[name="commit"]'

end
