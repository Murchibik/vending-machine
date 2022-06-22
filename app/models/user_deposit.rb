class UserDeposit < ApplicationRecord
  validates :amount, numericality: { greater_than: 0 }
end
