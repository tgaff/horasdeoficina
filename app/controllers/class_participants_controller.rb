class ClassParticipantsController < ApplicationController
  def show
    @wtbs = WeeklyTimeBlock.where(class_participant_id: params[:id])
    render layout: 'calendar_layout'
  end
  def last
    redirect_to ClassParticipant.last
  end
end
