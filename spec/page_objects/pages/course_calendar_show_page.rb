class CourseCalendarPage < SitePrism::Page
  section :calendar, WeekCalendarSection, '#calendar'

  element :instructions, '.help.well'

  element :display_form, '#form'

  element :progress_bar, '.covered-students .progress-bar'

  element :display_options_box, '.display-options'

  element :show_all_educator_availability_checkbox, '.display-options .show-all input'
  elements :show_educators_individual_availability_checkbox, '.display-options input' # this isn't accurate yet
  element :hide_times_checkbox, '.checkbox.hide-included input'


  element :excluded_students_table, 'table.excluded-students'
  element :included_students_table, 'table.included-students'
end
