module CoursesHelper

  # not totally convinced this shouldn't be in the Course model
  # but it does work on multiple models, so for now I'm setting it up as a helper
  #
  def as_an_educator(courses)
    courses.select do |c|
      c.course_participants.last.role.role_name == 'educator'
    end
  end
  def as_a_student(courses)
    as_a('student', courses)
  end

  private

  def as_a(role_name, courses)
    courses.select do |c|
      c.course_participants.first.role.role_name == role_name
    end
  end
end
