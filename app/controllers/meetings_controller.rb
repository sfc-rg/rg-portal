class MeetingsController < ApplicationController
  before_action :set_meeting, only: :show

  def index
    @meetings = Meeting.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
  end

  def new
    @meeting = Meeting.new
  end

  def create
    Meeting.new(meeting_params).save
    redirect_to meetings_path
  end

  private

  def set_meeting
    @meeting = Meeting.find(params[:id])
  end

  def meeting_params
    params.require(:meeting).permit(:name, :start_at, :end_at)
  end
end
