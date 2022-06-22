class HomeController < ApplicationController
  before_action :deposit

  # POST /input
  def input
    amount = params.permit(:amount)[:amount]
    deposit_service = ChangeDepositService.new(amount, deposit)
    deposit_service.call
  end

  # PATCH /cancel
  def cancel
    @change = deposit.amount
    deposit.update(amount: 0)
    @balance = 0
    check_deposit!
  end

  # GET /balance
  def my_balance
    @balance = deposit.amount
  end

  # POST /pick
  def pick
    service = MakePickService.new(params.permit(:code)[:code].to_i, deposit)
    result = service.call
    @product = result[:product]
    @change = result[:change]
    @balance = deposit.amount
    check_deposit!
  end

  private

  def deposit
    @deposit = if session[:deposit_id].blank?
                 UserDeposit.create(amount: 0)
               else
                 UserDeposit.find(session[:deposit_id])
               end
    session[:deposit_id] = @deposit.id
    @deposit
  end

  def check_deposit!
    return unless deposit.amount.zero?

    deposit.destroy
    session[:deposit_id] = nil
  end
end
