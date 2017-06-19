class GroupsController < ApplicationController
  before_action :require_login

  # Temporary constant for group expenses
  TMP_GROUP_EXPENSES = 1234

  def new
  end

  def index
    @groups = current_user.groups
  end

  def create
    current_user.groups.build(group_params)
    current_user.save
    redirect_to groups_path
  end

  def show
    @group = current_user.groups.find(params[:id])
  end

  def add_member
    @group = current_user.groups.find(params[:id])
  end

  private

  def group_params
    params.require(:group).permit(:title, :description)
  end
end
