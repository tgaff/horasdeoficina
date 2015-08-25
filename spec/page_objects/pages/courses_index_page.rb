class CoursesIndexPage < SitePrism::Page
  set_url '/courses'

  element :teaching_courses_table, 'div#teaching table'
  element :learning_courses_table, 'div#learning table'
  elements :teaching_courses, 'div#teaching tbody tr'
  elements :learning_courses, 'div#learning tbody tr'

end
