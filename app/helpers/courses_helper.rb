module CoursesHelper

  # not totally convinced this shouldn't be in the Course model
  # but it does work on multiple models, so for now I'm setting it up as a helper
  #
  def as_an_educator(courses)
    as_a('educator', courses)
  end
  def as_a_student(courses)
    as_a('student', courses)
  end


  #take a course and return something like:
  # { students: [ { email: 'g@g.com', created_at ...} , ],
  #  educators: [ { email... } ],
  #  others: []
  #  }
  def user_courses_by_type(course)
    students = []
    educators = []
    others = []
    course.course_participants.each do |cp|
      case cp.role.role_name
      when 'student'
        students << cp.user
      when 'educator'
        educators << cp.user
      else
        others << cp.user
      end
    end
    { students: students,
      educators: educators,
      others: others
    }
  end

  private

  def as_a(role_name, courses)
    courses.select do |c|
      c.course_participants.for_user(current_user).last.role.role_name == role_name
    end
  end
end


