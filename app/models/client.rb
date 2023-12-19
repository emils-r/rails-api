class Client < ApplicationRecord
  validates :name,
    presence: true,
    uniqueness: true,
    length: { minimum: 3, maximum: 50 }

  has_many :wallets

  default_scope { order(:id) }
end
