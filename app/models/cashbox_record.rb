class CashboxRecord < ApplicationRecord
  belongs_to :product, optional: true

  validates :amount, numericality: { greater_than: 0 }

  enum transaction_direction: { income: 0, refund: 1 }
end
