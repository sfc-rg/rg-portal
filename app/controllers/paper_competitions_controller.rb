class PaperCompetitionsController < ApplicationController
  before_action :require_active_current_user, except: :callback
  before_action :set_competiton, except: [:index, :new, :create]
  before_action :set_attendance, only: [:leave, :hook_config, :update_hook_config]
  protect_from_forgery except: :callback

  NUM_OF_COMPETITIONS_PER_PAGE = 20

  def index
    @competitions = PaperCompetition.page(params[:page]).per(NUM_OF_COMPETITIONS_PER_PAGE)
  end

  def new
    @competition = PaperCompetition.new
  end

  def edit

  end

  def create
    @competition = PaperCompetition.create!(paper_competition_params)
    redirect_to paper_competitions_path
  end

  def update
    if @competition.update(paper_competition_params)
      redirect_to paper_competition_path(@competition)
    else
      render :edit
    end
  end

  def destroy
    @competition.destroy
    redirect_to paper_competitions_path
  end

  def show
    # NOP
  end

  def join
    key = SSHKey.generate
    PaperCompetitionAttendance.create(paper_competition_attendance_params.merge(
      user: @current_user,
      paper_competition: @competition,
      private_key: key.private_key,
      public_key: key.ssh_public_key,
      callback_token: key.fingerprint.gsub(/:/, '')
    ))
    redirect_to hook_config_paper_competition_path
  end

  def leave

  end

  def hook_config
    # NOP
  end

  def update_hook_config
    if @attendance.update(paper_competition_attendance_params)
      redirect_to hook_config_paper_competition_path, flash: { success: 'Update Success!' }
    else
      render :hook_config
    end
  end

  def callback
    event = JSON.parse(request.raw_post)
    render nothing: true and return if request.env['HTTP_X_GITHUB_EVENT'] != 'push' && event['object_kind'] != 'push'

    attendance = PaperCompetitionAttendance.find_by(callback_token: params[:callback_token])
    render nothing: true and return if attendance.blank?

    latest_hash = event['commits'].last['id']
    latest_message = event['commits'].last['message']
    render nothing: true and return unless event['ref'].include?(attendance.target_branch)

    checkout_path = "/tmp/checkout-#{latest_hash}"
    num_of_commits =
      GitSSHWrapper.with_wrapper(private_key: attendance.private_key) do |wrapper|
        wrapper.set_env
        `git clone -b #{attendance.target_branch} #{attendance.target_repository} #{checkout_path}`
        `cd #{checkout_path} && git rev-list --count #{attendance.target_branch}`.chomp.to_i
      end

    file_path = [checkout_path, attendance.target_path].join('/')
    render nothing: true and return unless File.exist?(file_path)
    reader = PDF::Reader.new(file_path)
    PaperCompetitionCheckpoint.create(
      user: attendance.user,
      paper_competition: attendance.paper_competition,
      message: latest_message,
      num_of_pages: reader.pages.count,
      num_of_commits: num_of_commits,
    )

    FileUtils.rm_rf(checkout_path)
    render :nothing
  end

  private

  def set_competiton
    @competition = PaperCompetition.find(params[:id])
  end

  def set_attendance
    @attendance = PaperCompetitionAttendance.find_by(paper_competition: @competition, user: @current_user)
  end

  def paper_competition_params
    params.require(:paper_competition).permit(:name)
  end

  def paper_competition_attendance_params
    params.require(:paper_competition_attendance).permit(:target_repository, :target_branch, :target_path)
  end
end
