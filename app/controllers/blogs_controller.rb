class BlogsController < ApplicationController
  include EmojiComplete
  include UserComplete
  before_action :require_active_current_user
  before_action :set_page, only: :index
  before_action :set_user, only: [:index, :show, :update, :edit]
  before_action :set_blog, only: [:show, :update, :edit]
  before_action :check_update_permission, only: [:edit, :update]
  before_action :set_emoji_completion, only: [:new, :edit, :show]
  before_action :set_user_completion, only: [:new, :edit, :show]

  DEFAULT_BLOGS_PER_PAGE = 10

  def index
    @blogs = Blog.where(user: @user).order('created_at DESC').page(@page).per(DEFAULT_BLOGS_PER_PAGE)
  end

  def new
    @blog = Blog.new(user: @current_user)
  end

  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      redirect_to blog_path(@blog.to_param)
    else
      render :new
    end
  end

  def show
  end

  def update
    if @blog.update(blog_params)
      redirect_to blog_path(@blog.to_param)
    else
      render :edit
    end
  end

  def edit
  end

  private

  def set_page
    @page = [params[:page].to_i, 1].max
  end

  def set_user
    @user = User.find_by!(nickname: params[:nickname])
  end

  def set_blog
    # date = params[:timestamp]
    # timeoptions = [date[0...4], date[4...6], date[6...8], date[8...10], date[10...12], date[12...14], date[14...20]]
    @blog = Blog.find_by!(user: @user, timestamp: params[:timestamp])
  end

  def blog_params
    params.require(:blog).permit(:title, :content).merge(user: @current_user)
  end

  def check_update_permission
    redirect_to root_path if @blog.user != @current_user
  end
end
