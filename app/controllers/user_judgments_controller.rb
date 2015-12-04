class UserJudgementsController < ApplicationController
  before_action :require_active_current_user
  before_action :require_privilege, only: :index
  before_action :set_presentation, only: [:index, :create]
  before_action :set_user_judgement, only: :destroy
  before_action :require_ownership, only: :destroy

  def index
    @user_judgements = @presentation.user_judgements.includes(:user)
  end

  def create
    @user_judgement = @presentation.user_judgements.create!(user_judgement_params)
  end

  def destroy
    @user_judgement.destroy
    render :create
  end

  private

  def set_presentation
    @presentation = Presentation.find(params[:presentation_id])
  end

  def set_user_judgement
    @user_judgement = UserJudgement.find(params[:id])
  end

  def require_ownership
    head :forbidden unless @user_judgement.user.id == @current_user.id
  end

  def user_judgement_params
    params.require(:user_judgement).permit(:passed).merge(user: @current_user)
  end
end
