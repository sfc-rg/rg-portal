class BlogsController < ApplicationController
  before_action :set_user, except: :new
  before_action :set_blog, only: :show
  before_action :require_active_current_user

  def index
    @blogs = Blog.where(user: @user).order('created_at DESC')
  end

  def show
  end

  def new
    @blog = Blog.new
  end

  def update
    if params[:timestamp]
      set_blog
      @blog.update(blog_params)
    else
      @blog = Blog.new(blog_params)
      @blog.save
    end

    redirect_to blog_path
  end

  private

  def set_user
    @user = User.find_by!(nickname: params[:nickname])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  def set_blog
    @blog = Blog.find(created_at: params[:timestamp], user: @user)
    redirect_to blog_path if @blog.user != @user
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  def blog_params
    params.require(:blog).permit(:title, :content).merge(user: @current_user)
  end
end
