class GroupsController < ApplicationController
  before_action :require_login

  def new
  end

  def index
    @groups = current_user.groups.includes(:transactions)
  end

  def create
    current_user.groups.build(group_params)
    current_user.save
    redirect_to groups_path
  end

  def show
    @group = current_user.groups.find(params[:id])
    @expenses = Transaction.where(group_id: params[:id]).sum(&:amount)
  end

  def add_member
    @group = current_user.groups.find(params[:id])
  end

  def save_member
    email = params[:member][:email]
    member = User.includes([:groups]).find_by_email(email)
    group_id = params[:id]

    unless member.nil?
      group = Group.find(group_id)
      member.groups << group if group && !member.groups.include?(group)

      redirect_to group_path(group_id)
    else
      redirect_to add_member_path(group_id), alert: "User with email id '#{email}' is not present."
    end
  rescue
    redirect_to add_member_path(group_id),  notice: 'Something went wrong. Please try again.'
  end

  private

  def group_params
    params.require(:group).permit(:title, :description)
  end
end
