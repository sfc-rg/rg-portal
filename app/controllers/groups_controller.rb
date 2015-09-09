class GroupsController < ApplicationController
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
