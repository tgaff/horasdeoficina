class WeeklyTimeBlocksController < ApplicationController
  before_action :set_wtb, only: [:show, :destroy, :update ]

  def index
    @wtbs = WeeklyTimeBlock.all
  end

  def create
    @wtb = WeeklyTimeBlock.new(wtb_params)
    respond_to do |format|
      if @wtb.save
        format.json { render json: @wtb }
      else
        format.json { render json: @wtb.errors, status: :unprocessable_entity }
      end
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
    params.require(:wtb).permit(:from, :to, :can, :class_participant_id)
  end
end
