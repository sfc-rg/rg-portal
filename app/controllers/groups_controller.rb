class GroupsController < ApplicationController
  before_action :require_current_user
  def index
    @groups = Group.all
  end

  def create
    Group.new(group_params).save
    redirect_to groups_path
  end

  private

  def group_params
    params.require(:group).permit(:name, :kind)
  end
end
