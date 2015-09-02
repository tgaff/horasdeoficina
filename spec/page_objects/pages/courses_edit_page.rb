class CoursesEditPage < SitePrism::Page
  set_url '/courses/{course_id}/edit'
  set_url_matcher /courses.*\/edit/
  element :title_field, 'input#course_title'
  element :update_button, 'input[name="commit"]'

  element :edit_calendar_link, 'div#scheduling a'
  element :educators_table, 'table.type-educators'
  elements :educators, 'table.type-educators tbody tr'

  element :students_table, 'table.type-students'
  elements :students, 'table.type-students tbody tr'

end
