class ClassParticipantsController < ApplicationController
  def show
    @save = WeeklyTimeBlock.new
    @wtbs = WeeklyTimeBlock.where(class_participant_id: params[:id])
    @wtbs = WeeklyTimeBlock.all  # FIXME: remove this line!
    render layout: 'calendar_layout'
  end
  def last
    redirect_to ClassParticipant.last
  end
end
