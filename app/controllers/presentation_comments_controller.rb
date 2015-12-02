class PresentationCommentsController < CommentsController
  include SlackNotifier

  before_action :set_presentation, only: :index
  after_action :notify_new_comment, only: :create
  after_action :notify_mentions, only: :create

  def index
    return render json: { html: nil }, status: 404 if @presentation.blank?
    html = render_to_string(
      partial: 'comments/list',
      locals: {
        comments: @presentation.comments,
        new_comment: PresentationComment.new(presentation: @presentation),
      }
    )
    render json: { html: html }
  end

  protected

  def show_path(comment)
    presentation_path(comment.presentation)
  end

  private

  def set_presentation
    @presentation = Presentation.find_by(id: params[:presentation_id])
  end

  def notify_new_comment
    return if @comment.user == @comment.presentation.user
    message = "New comment on #{@comment.presentation.title} by #{@comment.user.nickname}\n#{@comment.content}\n#{presentation_url(@comment.presentation)}"
    slack_notify(from: @comment.user, to: @comment.presentation.user, message: message)
  end

  def notify_mentions
    usernames = @comment.content.scan(MENTION_USER_REGEX).map { |mention| mention[0] }
    mention_users = usernames.map { |username| User.find_by(nickname: username) }.compact
    mention_users.each do |mention_user|
      message = "New mention on #{@comment.presentation.title} by #{@comment.user.nickname}\n#{@comment.content}\n#{presentation_url(@comment.presentation)}"
      slack_notify(from: @comment.user, to: mention_user, message: message)
    end
  end
end
