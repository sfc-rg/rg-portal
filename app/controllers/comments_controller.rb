class CommentsController < ApplicationController
  MENTION_USER_REGEX = /@([A-z0-9]+)/

  before_action :require_active_current_user

  def create
    @comment = comment_class.create(comment_params)
    redirect_to show_path(@comment)
  end

  protected

  def notify_new_comment(from: nil, to: nil, title: nil)
    return if from == to || from.nil? || to.nil? || title.nil?
    message = "New comment on #{title} by #{from.nickname} #{show_url(@comment)}\n#{@comment.content}"
    slack_notify(from: from, to: to, message: message)
  end

  def notify_mentions(from: nil, title: nil)
    return if from.nil? || title.nil?
    usernames = @comment.content.scan(MENTION_USER_REGEX).map { |mention| mention[0] }
    mention_users = usernames.map { |username| User.find_by(nickname: username) }.compact
    mention_users.each do |mention_user|
      message = "New mention on #{title} by #{from.nickname} #{show_url(@comment)}\n#{@comment.content}"
      slack_notify(from: from, to: mention_user, message: message)
    end
  end

  private

  def type
    params[:type]
  end

  def comment_class
    type.constantize
  end

  def comment_params
    params.require(type.underscore.to_sym).permit(
      :page_id, :presentation_id, :content
    ).merge(user: @current_user)
  end
end
