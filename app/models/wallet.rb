class Wallet < ApplicationRecord
  belongs_to :client

  validates :currency, presence: true, length: { is: 3 }
  validates :client_id, presence: true
  validates :balance, comparison: { greater_than_or_equal_to: 0 }
end
