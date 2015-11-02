class PresentationsController < ApplicationController
  before_action :require_active_current_user
  before_action :set_meeting, only: [:new, :create]
  before_action :set_presentation, only: [:edit, :update, :destroy]

  def new
    @presentation = @meeting.presentations.build
    @presentation.presentation_handouts.build
  end

  def create
    @presentation = @meeting.presentations.build(presentation_params)
    if @presentation.save
      redirect_to meeting_path(@meeting)
    else
      render :new
    end
  end

  def edit
    @presentation.presentation_handouts.build
  end

  def update
    if @presentation.update(presentation_params)
      redirect_to meeting_path(@presentation.meeting)
    else
      render :edit
    end
  end

  def destroy
    @presentation.destroy
    redirect_to meeting_path(@presentation.meeting)
  end

  private

  def set_meeting
    @meeting = Meeting.find(params[:meeting_id])
  end

  def set_presentation
    @presentation = Presentation.find(params[:id])
  end

  def presentation_params
    params.require(:presentation).permit(
      :title, handouts_attributes: [:id, :file, :_destroy]
    ).merge(user: @current_user)
  end
end
