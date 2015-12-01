class UsersController < ApplicationController
  before_action :require_active_current_user

  def index
    @users = User.all
  end
end
