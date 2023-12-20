class Wallet < ApplicationRecord
  belongs_to :client

  validates :currency, presence: true, length: { is: 3 }, uniqueness: { scope: :client }
  validates :client_id, presence: true
  validates :balance, comparison: { greater_than_or_equal_to: 0 }

  default_scope { order(:id) }
  # default_scope { where(is_active: true) }

  def valid_balance(amount)
    balance >= amount
  end
end
