class BlogCommentsController < CommentsController
  include SlackNotifier

  before_action :set_blog, only: :index
  after_action :notify_new_comment, only: :create
  after_action :notify_mentions, only: :create

  def index
    return render json: { html: nil }, status: 404 if @blog.blank?
    html = render_to_string(
      partial: 'comments/list',
      locals: {
        comments: @blog.comments,
        new_comment: BlogComment.new(blog: @blog),
      }
    )
    render json: { html: html }
  end

  protected

  def type
    BlogComment.name
  end

  def show_path(comment)
    blog_path(comment.blog.to_param)
  end

  def show_url(comment)
    blog_url(comment.blog.to_param)
  end

  def notify_new_comment
    super(from: @comment.user, to: @comment.blog.user, title: @comment.blog.title)
  end

  def notify_mentions
    super(from: @comment.user, title: @comment.blog.title)
  end

  private

  def set_blog
    @blog = Blog.find_by(id: params[:blog_id])
  end
end
