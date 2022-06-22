class RestockService
  attr_reader :product, :quantity

  def initialize(product_id, quantity)
    @product = Product.find(product_id)
    @quantity = quantity.to_i
  end

  def call
    raise StandardError, 'Stock will not change' if quantity.zero?

    stock = product.stock_record
    updated_quantity = stock.quantity + quantity
    raise StandardError, 'After update stock should not be negative' if updated_quantity.negative?

    stock.update(quantity: updated_quantity)
  end
end