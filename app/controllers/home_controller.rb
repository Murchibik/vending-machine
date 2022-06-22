class HomeController < ApplicationController
  before_action :deposit

  def input
    amount = params.permit(:amount)
    validate_amount!(amount)
    deposit.update(amount: deposit.amount + amount)
    session[:input_amount] = deposit.amount
  end

  def cancel
    @amount = session[:input_amount]
    session[:input_amount] = 0
    deposit.update(amount: 0)
    @amount
  end

  def my_balance
    session[:input_amount]
  end

  def pick
    MakePickService.perform(params.permit(:code)[:code].to_i, deposit)
  end

  private

  def deposit
    @deposit = if session[:deposit_id].blank?
                 UserDeposit.create!(amount: 0)
               else
                 UserDeposit.find(session[:deposit_id])
               end
    session[:deposit_id] = @deposit.id
    @deposit
  end

  def validate_amount!(amount)
    raise StandardError, 'Incorrect amount' if amount <= 0
  end
end
