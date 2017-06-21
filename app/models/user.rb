class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :groups
  has_many :transactions

  def full_name
    [self.first_name, self.last_name].compact.join(' ')
  end

  def group_expenses(group_id)
    expenses = self.transactions.where(group_id: group_id)
    group_expenses = expenses.sum(&:amount)
    amount_paid = expenses.sum(&:amount_paid)

    net_amount = group_expenses - amount_paid

    "#{net_amount > 0 ? 'owed' : 'overpaid'} #{net_amount.abs}"
  rescue
    ''
  end
end
