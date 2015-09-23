class MeetingsController < ApplicationController
  def index
    @meetings = Meeting.all
  end

  def create
    Meeting.new(meeting_params).save
    redirect_to meetings_path
  end

  private

  def meeting_params
    params.require(:meeting).permit(:name, :start_at, :end_at)
  end
end
