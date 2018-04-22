class Api::V1::AttendancesController < Api::V1::BaseController
  before_action :require_api_key
  before_action :set_meeting
  before_action :set_user_by_student_id

  def create
    if MeetingAttendance.exists?(user: @user, meeting: @meeting)
      return render json: { error: 'Attendance already registered for this meeting.' }, status: 409
    end

    MeetingAttendance.create!(user: @user, meeting: @meeting)
  rescue
    render json: { error: 'Internal server error.' }, status: 500
  end

  private

  def set_meeting
    @meeting = Meeting.current
    render json: { error: 'No meeting in progress at this time.' }, status: 403 if @meeting.blank?
  end

  def set_user_by_student_id
    @user = LdapCredential.find_by(student_id: params[:student_id]).try(:user)
    render json: { error: 'No user found with specified student ID.' }, status: 403 if @user.blank?
  end
end
