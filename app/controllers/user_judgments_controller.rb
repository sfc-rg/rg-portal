class UserJudgmentsController < ApplicationController
  before_action :require_active_current_user
  before_action :require_privilege, only: :index
  before_action :set_presentation, only: :create
  before_action :set_user_judgment, only: :destroy
  before_action :require_ownership, only: :destroy

  def index
    @meeting = Meeting.includes(presentations: :user_judgments).find(params[:meeting_id])
  end

  def create
    @user_judgment = @presentation.user_judgments.create!(user_judgment_params)
  end

  def destroy
    @user_judgment.destroy
    render :create
  end

  private

  def set_presentation
    @presentation = Presentation.find(params[:presentation_id])
  end

  def set_user_judgment
    @user_judgment = UserJudgment.find(params[:id])
  end

  def require_ownership
    head :forbidden unless @user_judgment.user.id == @current_user.id
  end

  def user_judgment_params
    params.require(:user_judgment).permit(:passed).merge(user: @current_user)
  end
end
