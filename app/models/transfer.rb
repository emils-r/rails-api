class Transfer < ApplicationRecord
  validates :wallet_from, presence: true, numericality: { only_integer: true }
  validates :wallet_to, presence: true, numericality: { only_integer: true }
  validates :amount, presence: true, numericality: true, comparison: { greater_than_or_equal_to: 0.01 }
  validates :currency_from, length: { is: 3 }
  validates :currency_to, length: { is: 3 }
end
