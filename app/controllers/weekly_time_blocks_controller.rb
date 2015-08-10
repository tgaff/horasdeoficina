class WeeklyTimeBlocksController < ApplicationController
  before_action :set_wtb, only: [:show, :destroy, :update ]

  def index
    @wtbs = WeeklyTimeBlock.all
  end

  def create
    if params.has_key? :wtb
      @wtb = WeeklyTimeBlock.new(wtb_params)
      respond_to do |format|
        if @wtb.save
          format.json { render json: @wtb }
        else

        end
      end
    else
      # when multiple blocks are sent  we replace all
      # TODO: make sure it's only for the correct class_participant/user
      WeeklyTimeBlock.all.each(&:destroy!)
      wtbs = JSON.parse URI.decode wtb_params
      wtbs.each do |wtb|
        @wtb = WeeklyTimeBlock.new
        @wtb.from = DateTime.parse wtb['start']
        @wtb.to = DateTime.parse wtb['end']
        # need to set the class_participants
        @wtb.save!
      end
      redirect_to '/class_participants'
    end
  end

  def show
    respond_to do |format|
      format.json { render json: @wtb }
      format.html
    end
  end

  def destroy
    if @wtb
      @wtb.destroy
      respond_to do |format|
        format.json { head :no_content }
      end
    else

    end
  end

  def update
    respond_to do |format|
      if @wtb.update(wtb_params)
        format.json { render json: @wtb }
      else
        format.json { render json: @wtb.errors, status: :unprocessable_entity }
      end
    end
  end

private
  def set_wtb
    @wtb = WeeklyTimeBlock.find(params[:id])
  end
  def wtb_params
    if params[:wtbs]
      params.require(:wtbs)
    else
      params.require(:wtb).permit(:from, :to, :can, :class_participant_id)
    end

  end
end
