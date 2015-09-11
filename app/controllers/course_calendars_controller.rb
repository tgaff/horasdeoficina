class CourseCalendarsController < ApplicationController
  layout 'calendar_layout'

  def show
    @course_participants = Course.find(course_id).course_participants
  end

private

  def course_id
    params.require(:course_id).to_i
  end
end
