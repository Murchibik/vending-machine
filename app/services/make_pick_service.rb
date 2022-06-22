class MakePickService
  attr_reader :product, :deposit

  def initialize(code, deposit)
    @product = Product.find_by(code: code)
    @deposit = deposit
  end

  def call
    validate_product_and_stock!
    check_balance!
    do_a_pick
    { product: product, change: return_change }
  end

  private

  def check_balance!
    raise StandardError, 'Not enough money' if deposit.amount < product.price
  end

  def validate_product_and_stock!
    raise StandardError, 'Incorrect code' if product.blank?
    raise StandardError, 'Product is out of stock' if product.stock_record.quantity <= 0
  end

  def do_a_pick
    quantity = product.stock_record.quantity
    product.stock_record.update(quantity: quantity - 1)

    income_params = { product_id: product.id, transaction_direction: :income, amount: product.price }
    CashboxRecord.create(income_params)
  end

  def return_change
    change = deposit.amount - product.price
    deposit.update(amount: 0)
    change
  end

end