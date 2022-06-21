require 'rails_helper'

RSpec.describe CashboxRecord, type: :model do
  describe 'Columns' do
    it { should have_db_column(:transaction_direction).of_type(:integer) }
    it { should have_db_column(:amount).of_type(:integer) }
    it { should have_db_column(:product_id).of_type(:integer) }
    it { should have_db_column(:comment).of_type(:string) }
  end

  describe 'Validations' do
    it { should_not allow_value(-5).for(:amount) }
  end
end
