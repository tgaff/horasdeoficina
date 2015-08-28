class CoursesIndexPage < SitePrism::Page
  set_url '/courses'


  element :teaching_courses_table, 'div#teaching table'
  element :learning_courses_table, 'div#learning table'

  sections :teaching_courses, CourseListingSection, 'div#teaching tbody tr'
  sections :learning_courses, CourseListingSection, 'div#learning tbody tr'
  sections :all_courses, CourseListingSection, 'div.courses tbody tr'
end
