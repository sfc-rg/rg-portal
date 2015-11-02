class PresentationsController < ApplicationController
  before_action :require_active_current_user
  before_action :set_meeting, only: [:new, :create]

  def new
    @presentation = @meeting.presentations.build
    @presentation.presentation_handouts.build
  end

  def create
    @presentation = @meeting.presentations.build(meeting_params)
    @presentation.user = @current_user
    if @presentation.save
      redirect_to meeting_path(@meeting)
    else
      render :new
    end
  end

  private

  def set_meeting
    @meeting = Meeting.find(params[:meeting_id])
  end

  def meeting_params
    params.require(:presentation).permit(
      :title, handouts_attributes: [:file, :_destroy]
    )
  end
end
