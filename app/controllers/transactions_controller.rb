class TransactionsController < ApplicationController

  CHECK_BOX_CHECKED_VALUE = '1'
  DEFAULT_TRANSACTION_VALUE = 0.0

  def index
    @transactions = Transaction.includes([:user, :group])
                               .where(group_id: params[:id])
  end

  def new
    @group = Group.find(params[:id])
  end

  def create
    group_id, member_list, date, total_amount = form_params
    split_in = split_in(member_list)

    if split_in.zero?
      redirect_to new_transaction_path(id: group_id), alert: 'Select at least one member.'
      return
    end

    memeber_share = total_amount / split_in

    user_transactions = []
    members = User.where(email: member_list.keys)
    members.each do |member|
      amount = member_list[member.email][:value].eql?(CHECK_BOX_CHECKED_VALUE) ?
               memeber_share : DEFAULT_TRANSACTION_VALUE
      amount_paid = member_list[member.email][:amount_paid].to_f

      user_transactions << {
        group_id: group_id,
        date: date,
        amount: amount,
        user_id: member.id,
        amount_paid: amount_paid
      }

      total_amount -= amount_paid
    end

    unless total_amount.zero?
      redirect_to new_transaction_path(id: group_id), alert: 'The amount paid by individual and total expense does not match.'
      return
    end

    Transaction.create(user_transactions)

    redirect_to group_path(group_id)
  rescue
    redirect_to group_path(params[:transaction][:group_id]), notice: 'Something went wrong. Please try again.'
  end

  private
  def split_in(member_list)
    members = 0
    member_list.each do |_, v|
      members += 1 if CHECK_BOX_CHECKED_VALUE.eql?(v[:value])
    end

    members
  end

  def form_params
    transaction_params = params[:transaction]
    group_id = transaction_params[:group_id]
    member_list = transaction_params[:member_list]
    date = [
      transaction_params['date(1i)'.to_sym],
      transaction_params['date(2i)'.to_sym],
      transaction_params['date(3i)'.to_sym]
    ].join('/')
    total_amount = transaction_params[:amount].to_f

    [group_id, member_list, date, total_amount]
  end
end
