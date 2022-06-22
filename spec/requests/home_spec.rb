require 'rails_helper'

RSpec.describe "HomeController", type: :request do

  let(:first_product) { create(:product, name: 'Cookies', code: 1, price: 15) }
  let(:second_product) { create(:product, name: 'Apple', code: 2, price: 20) }
  let(:valid_code) { 1 }

  describe 'POST /input' do
    context 'When correct money amount' do
      it 'renders a successful response' do
        post products_url
        expect(response).to be_successful
      end
    end

    context 'When there is incorrect amount' do
      it 'should raise an error' do

      end
    end

    context 'When there is single product' do
      it 'renders a list with created product' do

      end
    end

    context 'When there is more than one product' do
      it 'renders a list with products' do

      end
    end
  end

  describe 'DELETE /cancel' do
    let(:deposit) { create(:user_deposit, amount: 10) }
    context 'When user clicks on cancel' do
      it 'Should return change' do

      end
    end
  end

  describe 'GET /my_balance' do
    context 'When user not add any funds' do
      it 'Should return zero balance' do

      end
    end

    context 'When user added funds' do
      it 'Should return balance of person' do

      end
    end
  end

  describe 'POST /pick' do
    context 'When user send incorrect code' do
      it 'Should get error about incorrect code' do

      end
    end

    context 'When user pick code, but the product out of stock' do
      it 'Should get error - product out of stock' do

      end
    end

    context 'When user pick code, but it is not enough funds' do
      it 'Should get error - not enough money' do

      end
    end

    context 'When all is correct' do
      it 'Should return product' do

      end

      it 'Should return change' do

      end
    end
  end
end
