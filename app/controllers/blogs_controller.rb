class BlogsController < ApplicationController
  before_action :require_active_current_user
  before_action :set_user, only: [:index, :show, :update, :edit]
  before_action :set_blog, only: [:show, :update, :edit]

  def index
    @blogs = Blog.where(user: @user).order('created_at DESC')
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

  def set_user
    @user = User.find_by!(nickname: params[:nickname])
  end

  def set_blog
    date = params[:timestamp]
    timeoptions = [date[0...4], date[4...6], date[6...8], date[8...10], date[10...12], date[12...14], date[14...20]]
    @blog = Blog.find_by!(user: @user, created_at: Time.local(*timeoptions.map(&:to_i)))
  end

  def blog_params
    params.require(:blog).permit(:title, :content).merge(user: @current_user)
  end
end
