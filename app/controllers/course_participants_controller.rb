class CourseParticipantsController < ApplicationController
  before_action :authenticate_user!

  def show
    @save = WeeklyTimeBlock.new
    @wtbs = get_current_wtbs
    @course_info = { course_title: get_course_participant.course.title }
    render layout: 'calendar_layout'
  end

  def save_calendar
    #WeeklyTimeBlock.all.each(&:destroy!)
    get_current_wtbs.each(&:destroy!)
    wtbs = JSON.parse URI.decode calendar_params[:wtbs]
    wtbs.each do |wtb|
      @wtb = WeeklyTimeBlock.new
      @wtb.from = parse_date_time( wtb['start'] )
      @wtb.to = parse_date_time( wtb['end'] )
      @wtb.course_participant = get_course_participant
      @wtb.save!
    end
    redirect_to course_calendar_path
  end

  private
  def calendar_params
    params.require(:wtbs)
    params.require(:course_id)
    params.permit(:wtbs, :course_id)
  end
  def parse_date_time(input)
    DateTime.strptime(input, '%Y-%m-%dT%H:%M')
  end
  def get_course_participant
    current_user.courses.find(params[:course_id]).course_participants.last
  end
  def get_current_wtbs
    @wtbs = WeeklyTimeBlock.where(course_participant: get_course_participant)
  end
end
