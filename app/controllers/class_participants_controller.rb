class ClassParticipantsController < ApplicationController
  def show
    @id = params[:id]
    @save = WeeklyTimeBlock.new
    @wtbs = WeeklyTimeBlock.where(class_participant_id: params[:id])
    render layout: 'calendar_layout'
  end

  def save_calendar
    WeeklyTimeBlock.all.each(&:destroy!)
    wtbs = JSON.parse URI.decode calendar_params
    wtbs.each do |wtb|
      @wtb = WeeklyTimeBlock.new
      @wtb.from = parse_date_time( wtb['start'] )
      @wtb.to = parse_date_time( wtb['end'] )
      @wtb.class_participant = ClassParticipant.find params[:id]
      @wtb.save!
    end
    redirect_to class_participant_path
  end
  def last
    redirect_to ClassParticipant.last
  end
  private
  def calendar_params
    params.require(:wtbs)
  end
  def parse_date_time(input)
    DateTime.strptime(input, '%Y-%m-%dT%H:%M')
  end
end
