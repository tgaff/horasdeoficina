class CourseListingSection < SitePrism::Section
  element :course_title, 'td:first-child'
  element :show_link, 'td:nth-child(2) a'
  element :edit_link, 'td:nth-child(3) a'
  element :edit_calendar_link, 'td:nth-child(4) a'
  element :destroy_link, 'td:nth-child(5) a'
end
