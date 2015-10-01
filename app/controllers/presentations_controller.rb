class PresentationsController < ApplicationController
  before_action :set_meeting, only: [:index, :new, :create]
  before_action :set_presentation, only: [:show, :edit, :update, :destroy]

  def index
    @presentations = @meeting.presentations
  end

  def show
  end

  def new
    @presentation = @meeting.presentations.build(user: @current_user)
  end

  def create
    @presentation = @meeting.presentations.build(presentation_params)
    @presentation.user = @current_user
    if @presentation.save
      render :show
    else
      render :new
    end
  end

  def edit
  end

  def update
    return render :edit unless @presentation.update(presentation_params)
    render :show
  end

  def destroy
    @presentation.destroy
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
      :title, :number,
      slide_attributes: :file,
      handout_attributes: :file
    )
  end
end
