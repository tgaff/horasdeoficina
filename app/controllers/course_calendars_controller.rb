class CourseCalendarsController < ApplicationController
  def show
    course = Course.find(course_id)
    @course_participants = course.course_participants
  end

private

  def course_id
    params.require(:course_id).to_i
  end
end
