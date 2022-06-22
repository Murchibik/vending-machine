require 'rails_helper'

RSpec.describe "HomeController", type: :request do

  let!(:first_product) { create(:product, :single, name: 'Cookies', code: 1, price: 15) }
  let!(:second_product) { create(:product, :single, name: 'Apple', code: 2, price: 20) }
  let(:valid_code) { 1 }
  let(:invalid_code) { 10 }

  describe 'POST /input' do
    context 'When input is correct money amount' do
      it 'renders a successful response' do
        post input_url, params: { amount: 10 }
        expect(response).to be_successful
      end

      it 'should change deposit amount to this sum' do
        post input_url, params: { amount: 10 }
        expect(UserDeposit.last.amount).to eq(10)
      end
    end

    context 'When few inputs one after another' do
      it 'should change deposit amount to this sum' do
        post input_url, params: { amount: 10 }
        post input_url, params: { amount: 20 }
        expect(UserDeposit.last.amount).to eq(30)
      end
    end

    context 'When there is incorrect amount' do
      it 'should raise an error' do
        expect {
          post input_url, params: { amount: 'amount' }
        }.to raise_error(StandardError, 'Incorrect amount')
      end

      it 'should raise an error' do
        expect {
          post input_url, params: { amount: -20 }
        }.to raise_error(StandardError, 'Incorrect amount')
      end
    end
  end

  describe 'GET /my_balance' do
    context 'When user not add any funds' do
      it 'Should return zero balance' do
        get balance_url
        expect(response.body).to include('0')
      end
    end

    context 'When user added funds' do
      it 'Should return balance of person' do
        post input_url, params: { amount: 50 }
        get balance_url
        expect(response.body).to include('50')
      end
    end
  end

  describe 'PATCH /cancel' do
    context 'When user clicks on cancel' do
      it 'Should return change' do
        post input_url, params: { amount: 50 }
        patch cancel_url
        expect(response.body).to include('Your change - 50')
        expect(response.body).to include('Your balance - 0')
      end
    end

    context 'When user clicks on cancel but deposit was empty' do
      it 'Should return change' do
        patch cancel_url
        expect(response.body).to include('Your change - 0')
        expect(response.body).to include('Your balance - 0')
      end
    end
  end

  describe 'POST /pick' do
    context 'When user send incorrect code' do
      it 'Should get error about incorrect code' do
        expect {
          post pick_url, params: { code: invalid_code }
        }.to raise_error(StandardError, 'Incorrect code')
      end
    end

    context 'When user pick code, but the product out of stock' do
      it 'Should get error - product out of stock' do
        post input_url, params: { amount: 10 }
        first_product.stock_record.update(quantity: 0)
        expect {
          post pick_url, params: { code: first_product.code }
        }.to raise_error(StandardError, 'Product is out of stock')
      end
    end

    context 'When user pick code, but it is not enough funds' do
      it 'Should get error - not enough money' do
        post input_url, params: { amount: 10 }
        expect {
          post pick_url, params: { code: first_product.code }
        }.to raise_error(StandardError, 'Not enough money')
      end
    end

    context 'When all is correct' do
      it 'Should return product' do
        post input_url, params: { amount: first_product.price }
        post pick_url, params: { code: first_product.code }
        expect(response.body).to include(first_product.name)
      end

      it 'Should return change' do
        post input_url, params: { amount: first_product.price + 10 }
        post pick_url, params: { code: first_product.code }
        expect(response.body).to include('Your change - 10')
        expect(response.body).to include('Your balance - 0')
      end
    end

    context 'When user try to buy two products and have enough funds' do
      it 'Should create two records in cashbox' do
        expect {
          post input_url, params: { amount: 35 }
          post pick_url, params: { code: first_product.code }
          post input_url, params: { amount: 20 }
          post pick_url, params: { code: second_product.code }
        }.to change(CashboxRecord, :count).by(2)
        expect(CashboxRecord.all.pluck(:amount).sum).to eq(35)
      end

      it 'Should return correct balance and products' do
        post input_url, params: { amount: 15 }
        post pick_url, params: { code: first_product.code }
        expect(response.body).to include(first_product.name)
        post input_url, params: { amount: 25 }
        post pick_url, params: { code: second_product.code }
        expect(response.body).to include(second_product.name)
        expect(response.body).to include('Your change - 5')
        expect(response.body).to include('Your balance - 0')
      end
    end
  end
end
