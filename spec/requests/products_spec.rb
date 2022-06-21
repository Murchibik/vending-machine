require 'rails_helper'

RSpec.describe "/products", type: :request do

  let(:valid_attributes) { { name: 'Cookies', code: 1, price: 15 } }
  let(:invalid_attributes) { { name: '', code: 1, price: -2 } }

  describe 'GET /index' do
    context 'When there are no products' do
      it 'renders a successful response' do
        get products_url
        expect(response).to be_successful
      end
    end

    context 'When there is single product' do
      it 'renders a list with created product' do
        product = create(:product, :single, name: 'Apple')
        get products_url
        expect(response.body).to include(product.name)
        expect(response.body).to include(product.price.to_s)
        expect(response.body).to include(product.stock_record.quantity.to_s)
        expect(response.body).not_to include('Banana')
      end
    end

    context 'When there is more than one product' do
      it 'renders a list with products' do
        apple = create(:product, name: 'Apple', code: 1)
        banana = create(:product, name: 'Banana', code: 2)
        get products_url
        expect(response.body).to include(apple.name)
        expect(response.body).to include(banana.name)
      end
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_product_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      product = create(:product)
      get edit_product_url(product)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Product' do
        expect {
          post products_url, params: { product: valid_attributes }
        }.to change(Product, :count).by(1)
      end

      it 'redirects to the created product' do
        post products_url, params: { product: valid_attributes }
        expect(response).to redirect_to(product_url(Product.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Product' do
        expect {
          post products_url, params: { product: invalid_attributes }
        }.to change(Product, :count).by(0)
      end

      it 'failed with error' do
        post products_url, params: { product: invalid_attributes }
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) { { name: 'Cookies with chocolate', code: 1, price: 20 } }

      it 'updates the requested product' do
        product = create(:product, valid_attributes)
        patch product_url(product), params: { product: new_attributes }
        product.reload
        expect(product.name).to eq(new_attributes[:name])
        expect(product.name).not_to eq(valid_attributes[:name])
        expect(product.price).to eq(new_attributes[:price])
        expect(product.price).not_to eq(valid_attributes[:price])
      end

      it 'redirects to the product' do
        product = create(:product, valid_attributes)
        patch product_url(product), params: { product: new_attributes }
        product.reload
        expect(response).to redirect_to(product_url(product))
      end
    end

    context 'with invalid parameters' do
      it 'raise validation error' do
        product = create(:product)
        patch product_url(product), params: { product: invalid_attributes }
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'DELETE /destroy' do
    let!(:product) { create(:product) }
    it 'destroys the requested product' do
      expect {
        delete product_url(product)
      }.to change(Product, :count).by(-1)
      expect(response).to redirect_to(products_url)
    end
  end
end
