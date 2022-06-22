class ChangeDepositService
  attr_reader :deposit, :amount

  def initialize(amount, deposit)
    @amount = amount.to_i
    @deposit = deposit
  end

  def call
    raise StandardError, 'Incorrect amount' if amount <= 0

    deposit.update(amount: deposit.amount + amount)
  end
end