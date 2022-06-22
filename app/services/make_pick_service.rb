class MakePickService
  attr_reader :product, :input_amount

  def initialize(code, input_amount)
    @product = Product.find_by(code: code)
    @input_amount = input_amount
  end

  def call
    validate_product_and_stock!
    check_balance
    do_a_pick
  end

  private

  def check_balance

  end

  def validate_product_and_stock!
    raise StandartError, 'incorrect code' if product.blank?
    raise StandartError, 'product not in stock' if product.stock_record.quantity <= 0
  end

  def do_a_pick
    quantity = product.stock_record.quantity
    product.stock_record.update(quantity: quantity - 1)

    income_params = { product_id: product.id,  }
    CashboxRecord.create(income_params)
  end

end