class CourseCalendarsController < ApplicationController
  layout 'calendar_layout'

  def show
    @course_participants = course.course_participants
    @course_info = { title: course.title }
    @wtbs = WeeklyTimeBlock.where(course: course)
  end

private

  def course_id
    params.require(:course_id).to_i
  end

  def course
    Course.find(course_id)
  end
end
