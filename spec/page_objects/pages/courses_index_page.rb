class TestSection2 < DynamicSection
  element :test2,  'h2'
  set_default_locator 'div#user-info'

end

class TestSection < DynamicSection
  element :test, 'h3'
  set_default_locator 'h3'
end
class CoursesIndexPage < DynamicPage

  COMPONENT_DICTIONARY = {
    test_a: {class: TestSection, selector: 'h3'},
    test_b: {class: TestSection2, selector: 'div#user-info'},
  }


  def add_components(*components)
    Array(components).each do |component|
      metaclass = class << self; self; end
      metaclass.section(component, COMPONENT_DICTIONARY[component][:class], COMPONENT_DICTIONARY[component][:selector])
    end
  end

  set_url '/courses'

  element :teaching_courses_table, 'div#teaching table'
  element :learning_courses_table, 'div#learning table'
  elements :teaching_courses, 'div#teaching tbody tr'
  elements :learning_courses, 'div#learning tbody tr'


end
