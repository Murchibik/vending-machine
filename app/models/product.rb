class Product < ApplicationRecord
  has_one :stock_record, dependent: :destroy
  has_many :cashbox_records

  validates :code, uniqueness: true
  validates :name, presence: true
  validates :price, :code, numericality: { greater_than: 0 }
end
