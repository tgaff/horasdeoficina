class CourseCalendarPage < SitePrism::Page
  element :calendar, WeekCalendarSection, '#calendar'

  element :instructions, '.help.well'
end
