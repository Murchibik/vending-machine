require 'rails_helper'

RSpec.describe StockRecord, type: :model do
  describe 'Columns' do
    it { should have_db_column(:product_id).of_type(:integer) }
    it { should have_db_column(:quantity).of_type(:integer) }
  end

  describe 'Associations' do
    it { should belong_to(:product) }
  end

  describe 'Validations' do
    it { should_not allow_value(-5).for(:quantity) }
  end
end
